
//"SPDX-License-Identifier:UNLICENSE" 
pragma solidity ^0.8.4;


contract Bidding_System{

  event new_bidder(address, uint);
  event new_highest_bid(address, uint);

  uint max=0;
  mapping (address => uint) public particular_bidder;
  mapping (uint => address) particular_bid;
  uint[] detail;

    uint time_limit = block.timestamp + 604800;

     modifier time_in{
      require (block.timestamp < time_limit);
      _;
   }
   
  

  function new_bids(address _bidder,uint _bid) public time_in{
    require(_bid > 0,"bid should atleast be 1");
    require(particular_bidder[_bidder] < _bid  ,"bid less than previous bid");
    detail.push(_bid);
    particular_bidder[_bidder]=_bid;
    particular_bid[_bid]=_bidder;
    emit new_bidder(_bidder,_bid);
  }
  
  function highestbid() public returns(address, uint) {

    for(uint i=0; i < detail.length; ++i){
      if(max < detail[i]){
        max = detail[i];
      }
    } 
        emit new_highest_bid(particular_bid[max],max);
        return (particular_bid[max],max);
  }
 
}