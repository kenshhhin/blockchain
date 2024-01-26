// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address public owner;
    address public lastRecipient;
    uint256 public lastTransactionTimestamp;

    constructor() ERC20("<AITU_Ilan>", "UNF") {
        owner = msg.sender;
        _mint(msg.sender, 2000 * (10**decimals()));
    }

    function transferTokens(address to, uint256 amount) public {
        require(to != address(0), "Invalid address");
        require(amount <= balanceOf(msg.sender), "Insufficient balance");

        _transfer(msg.sender, to, amount);
        lastRecipient = to;
        lastTransactionTimestamp = block.timestamp;
    }

    function getLatestTransactionTimestamp() public view returns (string memory) {
        return timestampToString(lastTransactionTimestamp);
    }

    function getTransactionSender() public view returns (address) {
        return msg.sender;
    }

    function getTransactionReceiver() public view returns (address) {
        return lastRecipient;
    }

    function timestampToString(uint256 timestamp) internal pure returns (string memory) {
        return uintToString(timestamp);
    }

    function uintToString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + value % 10));
            value /= 10;
        }
        return string(buffer);
    }
}

