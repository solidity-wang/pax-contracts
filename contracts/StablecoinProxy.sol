pragma solidity ^0.4.24;


import "./UpgradeabilityStorage.sol";
import "./StablecoinEventInterface.sol";


/**
 * @title StablecoinProxy
 * @dev This proxy contract looks at the address for the implementation
 * and forwards *all* calls to the implementation contract; there are
 * no external functions in this Proxy contract. This Proxy will
 * be deployed after the first logic contract is up so that we can
 * fill in the initial implementation in the constructor.
 * NOTE: This runs the implementation contract's logic, but in the context of
 * this contract. All relevant the storage for the actual contract is eternally
 * in this Proxy contract and never in the implementation contract itself.
 */
contract StablecoinProxy is UpgradeabilityStorage, StablecoinEventInterface {

    /**
     * GENERIC DELEGATION PROXY FUNCTIONALITY
     */

    /**
     * @dev Contract constructor.
     * @param _impl Address of the initial implementation.
     */
    constructor(address _impl) public {
        _setImplementation(_impl);
    }


    /**
     * @dev Fallback function.
     * Implemented entirely in `_delegate`.
     */
    function () external payable {
        _delegate();
    }

    /**
     * @dev Delegates execution to an implementation contract.
     * This is a low level function that doesn't return to its internal call site.
     * It will return to the external caller whatever the implementation returns.
     * NOTE: This runs the implementation contract's logic, but in the context of
     * this contract. All relevant the storage for the actual contract is eternally
     * in this Proxy contract and never in the implementation contract itself.
     */
    function _delegate() internal {
        address impl = _implementation();

        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.
            calldatacopy(0, 0, calldatasize)

            // Call the implementation.
            // out and outsize are 0 because we don't know the size yet.
            let result := delegatecall(gas, impl, 0, calldatasize, 0, 0)

            // Copy the returned data.
            returndatacopy(0, 0, returndatasize)

            switch result
            // delegatecall returns 0 on error.
            case 0 { revert(0, returndatasize) }
            default { return(0, returndatasize) }
        }
    }

    /**
     * DELEGATED Stablecoin PUBLIC INTERFACE
     */

    // ERC20 BASIC INTERFACE

    function name() public view returns (string) {
        _delegate();
    }

    function symbol() public view returns (string) {
        _delegate();
    }

    function decimals() public view returns (uint8) {
        _delegate();
    }

    function totalSupply() public view returns (uint256) {
        _delegate();
    }

    function balanceOf(address who) public view returns (uint256) {
        _delegate();
    }

    function transfer(address to, uint256 value) public returns (bool) {
        _delegate();
    }

    // OWNABLE INTERFACE

    function owner() public view returns (address) {
        _delegate();
    }

    function transferOwnership(address _newOwner) public {
        _delegate();
    }

    // PAUSABLE INTERFACE

    function paused() public view returns (address) {
        _delegate();
    }

    function pause() public {
        _delegate();
    }

    function unpause() public {
        _delegate();
    }

    // SUPPLY CONTROL INTERFACE

    function supplyController() public view returns (address) {
        _delegate();
    }

    function setSupplyController(address _newSupplyController) public {
        _delegate();
    }

    function increaseSupply(uint256 _value) public returns (bool success) {
        _delegate();
    }

    function decreaseSupply(uint256 _value) public returns (bool success) {
        _delegate();
    }

    // UPGRADEABILITY INTERFACE

    function upgradeTo(address newImplementation) public {
        _delegate();
    }

    function implementation() public view returns (address) {
        _delegate();
    }
}
