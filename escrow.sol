pragma solidity ^0.4.21;

contract Escrow{
    
    enum State {AWAITING_BOUNTY, AWAITING_ANSWER, COMPLETE}
    
    State public currentState;
    
    address public asker;
    address public answerer;
    
    modifier askerOnly {require(msg.sender == asker); _;}
    
    constructor (address _buyer, address _seller){
        asker = _buyer;
        answerer = _seller;
    }
    
    function confirmPayment() askerOnly payable {
        require(currentState == State.AWAITING_BOUNTY);
        currentState == State.AWAITING_ANSWER;
    }
    
    function confirmAnswered() askerOnly {
        require(currentState == State.AWAITING_ANSWER);
        answerer.send(this.balance);
        currentState == State.COMPLETE;
    }
}