// zcoin ICO
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract zcoin_ico{
    // max number of zcoins available for sale
    uint public max_zcoins = 1000000;
    
    // USD to zcoins conversion rate
    uint public usd_to_zcoins = 1000;

    // number of zcoin sold
    uint public total_zcoins_bought = 0;

    // Mapping from the investor address to its equity in zcoins and USD
    mapping(address => uint) equity_zcoins;
    mapping(address => uint) equity_usd;

    // check if an investor can buy zcoins
    modifier can_buy_zcoins(uint usd_invested){
        require(usd_invested * usd_to_zcoins + total_zcoins_bought <= max_zcoins);
        _;
    }
    // Getting the equity in zcoins of an investor
    function equity_in_zcoin(address investor) external view returns (uint){
        return equity_zcoins[investor];
    }
    // Getting the equity in USD of an investor
    function equity_in_USD(address investor) external view returns (uint){
        return equity_usd[investor];
    }

    // buying zcoins
    function buy_zcoin(address investor, uint usd_invested) external can_buy_zcoins(usd_invested){
        uint zcoins_bought = usd_invested * usd_to_zcoins;
        equity_zcoins[investor] += zcoins_bought;
        equity_usd[investor] += usd_invested;
        total_zcoins_bought += zcoins_bought;
    }

    // selling zcoins
    function sell_zcoin(address investor, uint zcoins_sold) external{
        equity_zcoins[investor] -= zcoins_sold;
        equity_usd[investor] -= zcoins_sold / usd_to_zcoins;
        total_zcoins_bought -= zcoins_sold;
    }
}