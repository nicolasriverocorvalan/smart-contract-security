// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
 * @title PasswordStore
 * @notice This contract allows you to store a private password that others won't be able to see. 
 * You can update your password at any time.
 */
 
contract PasswordStore {
    error PasswordStore__NotOwner();

    address private s_owner;
    string private s_password; // @audit: This variable is not secure, as it is public and can be accessed by anyone

    event SetNetPassword();

    constructor() {
        s_owner = msg.sender;
    }

    /*
     * @notice This function allows only the owner to set a new password.
     * @param newPassword The new password to set.
     */
    // @audit This function is not secure, as it allows anyone to set the password
    // missing access control

    modifier onlyOwner {
        require(msg.sender == s_owner, "Only the contract owner can call this function");
        _;
    }

    function setPassword(string memory newPassword) external onlyOwner {
        // Check that the new password is not empty
        require(bytes(newPassword).length > 0, "Password should not be empty");

        s_password = newPassword;
        emit SetNetPassword();
    }
    /*
     * @notice This allows only the owner to retrieve the password.
     * @param newPassword The new password to set.
     */
     // @audit there is no parameter to retrieve the password
    function getPassword() external view returns (string memory) {
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        return s_password;
    }
}
