pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/token/StandardToken.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

/**
 * @title ArioToken
 */
contract ArioToken is StandardToken {

  using SafeMath for uint256;

  /**
  * Initial token state
  **/

  string public constant name = "Ario Token";
  string public constant symbol = "ARIO";
  uint8 public constant decimals = 18;

  uint256 public constant INITIAL_SUPPLY = 0;
  address public ico;

  /////

  event Mint(address indexed to, uint256 amount);
  event MintFinished();

  bool public mintingFinished = false;

  modifier canMint() {
    require(!mintingFinished);
    _;
  }

  /**
   * @dev Constructor for creatte token.
   */
  function ArioToken(address _ico) public {
    totalSupply = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
    ico = _ico;
  }

  /**
   * @dev Function to mint tokens for ico contract
   * @param _to The address that will receive the minted tokens.
   * @param _amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address _to, uint256 _amount) canMint public returns (bool) {
    require(msg.sender == ico);
    require(_amount != 0);

    totalSupply = totalSupply.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    Mint(_to, _amount);
    Transfer(0x0, _to, _amount);
    return true;
  }

  function finishMinting() public returns (bool) {
    require(msg.sender == ico);
    
    mintingFinished = true;
    MintFinished();
    return true;
  }
}
