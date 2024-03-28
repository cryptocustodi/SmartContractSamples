// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract BondMarket {
    struct Bond {
        uint256 id;
        string name;
        uint256 faceValue; // Face value of the bond
        uint256 maturityDate; // Timestamp when the bond matures
        uint256 couponRate; // Annual coupon rate (in basis points)
        uint256 remainingSupply; // Remaining supply of the bond
        address payable issuer; // Address of the bond issuer
    }

    mapping(uint256 => Bond) public bonds; // Mapping of bond ID to Bond struct
    uint256 public nextBondId = 1; // Counter for generating unique bond IDs
    mapping(address => uint256[]) public ownedBonds; // Mapping of address to array of owned bond IDs
    mapping(uint256 => mapping(address => uint256)) public bondBalances; // Mapping of bond ID to owner address to bond balance

    event BondIssued(
        uint256 indexed id,
        string name,
        uint256 faceValue,
        uint256 maturityDate,
        uint256 couponRate,
        uint256 supply,
        address indexed issuer
    );
    event BondPurchased(
        uint256 indexed id,
        address indexed buyer,
        uint256 amount
    );
    event BondSold(uint256 indexed id, address indexed seller, uint256 amount);

    // Function to issue a new bond
    function issueBond(
        string memory _name,
        uint256 _faceValue,
        uint256 _maturityDate,
        uint256 _couponRate,
        uint256 _supply
    ) external {
        require(
            _maturityDate > block.timestamp,
            "Maturity date must be in the future"
        );
        require(_couponRate > 0, "Coupon rate must be greater than zero");
        require(_supply > 0, "Supply must be greater than zero");

        Bond memory newBond = Bond({
            id: nextBondId,
            name: _name,
            faceValue: _faceValue,
            maturityDate: _maturityDate,
            couponRate: _couponRate,
            remainingSupply: _supply,
            issuer: payable(msg.sender)
        });

        bonds[nextBondId] = newBond;
        nextBondId++;

        emit BondIssued(
            newBond.id,
            newBond.name,
            newBond.faceValue,
            newBond.maturityDate,
            newBond.couponRate,
            newBond.remainingSupply,
            newBond.issuer
        );
    }

    // Function to buy bonds
    function buyBond(uint256 _id, uint256 _amount) external payable {
        Bond storage bond = bonds[_id];
        require(bond.id != 0, "Bond does not exist");
        require(bond.remainingSupply >= _amount, "Not enough bonds available");

        uint256 cost = bond.faceValue * _amount;
        require(msg.value >= cost, "Insufficient funds");

        bond.remainingSupply -= _amount;
        bondBalances[_id][msg.sender] += _amount;
        ownedBonds[msg.sender].push(_id);

        if (msg.value > cost) {
            payable(msg.sender).transfer(msg.value - cost); // Refund excess payment
        }

        emit BondPurchased(_id, msg.sender, _amount);
    }

    // Function to sell bonds
    function sellBond(uint256 _id, uint256 _amount) external {
        Bond storage bond = bonds[_id];
        require(bond.id != 0, "Bond does not exist");
        require(
            bondBalances[_id][msg.sender] >= _amount,
            "Not enough bonds owned"
        );

        uint256 saleAmount = bond.faceValue * _amount;
        bond.remainingSupply += _amount;
        bondBalances[_id][msg.sender] -= _amount;
        payable(msg.sender).transfer(saleAmount);

        emit BondSold(_id, msg.sender, _amount);
    }

    // Function to retrieve bond details
    function getBondDetails(
        uint256 _id
    )
        external
        view
        returns (
            uint256,
            string memory,
            uint256,
            uint256,
            uint256,
            uint256,
            address
        )
    {
        Bond memory bond = bonds[_id];
        require(bond.id != 0, "Bond does not exist");

        return (
            bond.id,
            bond.name,
            bond.faceValue,
            bond.maturityDate,
            bond.couponRate,
            bond.remainingSupply,
            bond.issuer
        );
    }

    //ToDo:CUSIP Generator?
    //ToDo:interest payments
    //ToDo:expand buy/sell params to open bid/ask spread (not face value (i.e. market/strike))
    //ToDo:secondary market trading (list all issuance/list order book, bid/ask orders, market maker???, order types)
    //ToDo:enforce > 0% coupon??
}
