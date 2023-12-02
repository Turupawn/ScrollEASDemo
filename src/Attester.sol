// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import { IEAS, AttestationRequest, AttestationRequestData, RevocationRequest, RevocationRequestData } from "@eas-contracts/IEAS.sol";
import { NO_EXPIRATION_TIME, EMPTY_UID } from "@eas-contracts/Common.sol";

/// @title Attester
/// @notice Ethereum Attestation Service - Example
contract Attester {
    error InvalidEAS();

    // The address of the global EAS contract.
    IEAS private immutable _eas;

    /// @notice Creates a new Attester instance.
    /// @param eas The address of the global EAS contract.
    constructor(IEAS eas) {
        if (address(eas) == address(0)) {
            revert InvalidEAS();
        }

        _eas = eas;
    }

    /// @notice Attests to a schema that receives a uint256 parameter.
    /// @param schema The schema UID to attest to.
    /// @param message The string value to pass to to the resolver.
    /// @return The UID of the new attestation.
    function attest(bytes32 schema, string memory message) external returns (bytes32) {
        return
            _eas.attest(
                AttestationRequest({
                    schema: schema,
                    data: AttestationRequestData({
                        recipient: address(0), // No recipient
                        expirationTime: NO_EXPIRATION_TIME, // No expiration time
                        revocable: true,
                        refUID: EMPTY_UID, // No references UI
                        data: abi.encode(msg.sender, message), // Encode the sender address and the string message as a parameter to the schema
                        value: 0 // No value/ETH
                    })
                })
            );
    }

    /// @notice Revokes an attestation of a schema that receives a uint256 parameter.
    /// @param schema The schema UID to attest to.
    /// @param uid The UID of the attestation to revoke.
    function revoke(bytes32 schema, bytes32 uid) external {
        _eas.revoke(RevocationRequest({ schema: schema, data: RevocationRequestData({ uid: uid, value: 0 }) }));
    }
}