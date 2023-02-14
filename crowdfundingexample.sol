pragma solidity ^0.8.0;

contract Crowdfund {
    uint256 public goal;
    uint256 public funding;
    address public creator;

    event FundTransfer(
        address backer,
        uint256 amount,
        uint256 total
    );

    constructor(uint256 _goal) public {
        goal = _goal;
        creator = msg.sender;
    }

    function contribute() public payable {
        require(msg.value > 0, "Must contribute a positive amount");
        funding += msg.value;
        emit FundTransfer(msg.sender, msg.value, funding);
    }

    function checkGoalReached() public view returns (bool) {
        return funding >= goal;
    }

    function refund() public {
        require(checkGoalReached() == false, "Goal reached, no refunds");
        require(msg.sender == creator, "Only creator can refund");
        uint256 amount = funding;
        funding = 0;
        msg.sender.transfer(amount);
    }
}
