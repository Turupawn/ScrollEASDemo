// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Attester} from "../src/Attester.sol";

import { IEAS, AttestationRequest, AttestationRequestData, RevocationRequest, RevocationRequestData } from "@eas-contracts/IEAS.sol";
import { ISchemaRegistry, SchemaRecord, ISchemaResolver } from "@eas-contracts/ISchemaRegistry.sol";
import { NO_EXPIRATION_TIME, EMPTY_UID } from "@eas-contracts/Common.sol";

contract AttesterTest is Test {
    Attester public attester;

    address eas = 0xaEF4103A04090071165F78D45D83A0C0782c2B2a;
    address schemaRegistry = 0x55D26f9ae0203EF95494AE4C170eD35f4Cf77797;
    bytes32 schemaID;

    function setUp() public {
        schemaID = ISchemaRegistry(schemaRegistry).register(
            "address from, string messageDemo",
            ISchemaResolver(address(0)),
            true);
        
        attester = new Attester(IEAS(eas));

        console2.logString("You created the following Schema:");
        console2.logBytes32(schemaID);
    }

    function test_Attest() public {
        bytes32 attestationID = attester.attest(schemaID, "Hello Scroll Sepola EAS!");
        console2.logString("You submitted the following Attestestation:");
        console2.logBytes32(attestationID);
    }
}
