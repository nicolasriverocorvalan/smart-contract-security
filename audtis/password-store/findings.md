# Security Findings

## [H-1] Storing the password on-chain makes it visible to anyone, and no longer private.

### Description

All data stored on-chain is visible to anyone, and can be read directly from the blockchain. The `PasswordStore::s_password` variable is intended to be a private variable and only accessed through the `PasswordStore::getPassword` function, which is intended to be only called by the owner of the contract.

We show one such method of reading any data off chain below.

### Impact

Anyone can read the private password, severly breaking the functionality of the protocol.

### PoC

The below test case shows how anyone can read the password directly from the blockchain.

1. Create a locally running chain.

```bash
make anvil
```

2. Deploy the contract to the chain.
   
```bash
make deploy
```

3. Run the storage tool.

We use `1` because that's the storage slot of `s_password` in the contract.
   
```bash
cast storage 0x5FbDB2315678afecb367f032d93F642f64180aa3 1
```

You'll get an output that looks like this:

`0x6d7950617373776f726400000000000000000000000000000000000000000014`

You can then parse that hex to a string with:

```bash
cast parse-bytes32-string 0x6d7950617373776f726400000000000000000000000000000000000000000014
```

And get an output of:

```
myPassword
```

### Recommended mitigation

Due to this, the overall architecture of the contract should be rethought. One could encrypt the password off-chain, and then storage the encrypted password on-chain. However, you'd also likely want to remove the view function as you wouldn't want the user to accidentally send a transaction with the password that decrypts your password.

## [H-2] `PasswordStore::setPassword` has no access control, meaning a non-owner could change the password.

### Description

The `PasswordStore::setPassword` function is set to be an `external` function, however, the natspec of the function and overall purpose of the smart contract is that `that function allows only the owner to set a new password`.

```javascript
    function setPassword(string memory newPassword) external {
 @>     // @audit - there are no access controls       
        s_password = newPassword;
        emit SetNetPassword();
    }
```

### Impact

Anyone can change/set the password of the contract, severly breaking the contract intended functionality.

### PoC

Add the following to the `PasswordStore.t.sol` test file:

<details>
<summary> Code </summary>

```javascript
    function test_anyone_can_set_password(address randomAddress) public {
        vm.assume(randomAddress != owner);
        vm.prank(randomAddress);
        string memory expectedPassword = "myNewPassword";
        passwordStore.setPassword(expectedPassword);
        
        vm.prank(owner);
        string memory actualPassword = passwordStore.getPassword();
        assertEq(actualPassword, expectedPassword);
    }
````
</details>

### Recommended mitigation

Add an access control conditional to check that the sender of the transaction (`msg.sender`) is the same as the `stored owner of the contract`. If the condition is not met, the transaction is reverted and the error message is returned.

```javascript
    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
    
    function setPassword(string memory newPassword) external onlyOwner {
        // Check that the new password is not empty
        require(bytes(newPassword).length > 0, "Password should not be empty");

        s_password = newPassword;
        emit SetNetPassword();
    }
```

## [I-1] The `PasswordStore::getPassword` natspec indicates a parameter that doesn't exist, causing the natspec to be incorrect.

### Description

```javascript
    /*
     * @notice This allows only the owner to retrieve the password.
@>   * @param newPassword The new password to set.
     */
    function getPassword() external view returns (string memory) {
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        return s_password;
    }
```

The `PasswordStore::getPassword` function signature is `getPassword()` while the natspec says it should be `getPassword(String)`.

### Impact

The natspec is incorrect.

### Recommended Mitigation

Remove the incorrect natspec line.

```diff
-  * @param newPassword The new password to set.
```
