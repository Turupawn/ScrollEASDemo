// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {console2} from "forge-std/Test.sol";
import {Attester} from "../src/Attester.sol";

import { IEAS, AttestationRequest, AttestationRequestData, RevocationRequest, RevocationRequestData } from "@eas-contracts/IEAS.sol";
import { ISchemaRegistry, SchemaRecord, ISchemaResolver } from "@eas-contracts/ISchemaRegistry.sol";
import { NO_EXPIRATION_TIME, EMPTY_UID } from "@eas-contracts/Common.sol";

contract MyScript is Script {
    address eas = 0xaEF4103A04090071165F78D45D83A0C0782c2B2a;
    address schemaRegistry = 0x55D26f9ae0203EF95494AE4C170eD35f4Cf77797;
    bytes32 schemaID = 0x32320d0e5848acba5b0ed648e27d906a5caf99f348c61422a05e239307a84caf;
    Attester attester;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Schemas can't be duplicate, the following commented code can only be run once
        /*
        schemaID = ISchemaRegistry(schemaRegistry).register(
            "address from, string message",
            ISchemaResolver(address(0)),
            true);
        */

        attester = new Attester(IEAS(eas));
        
        console2.logString("You created the following Attester contract:");
        console2.logAddress(address(attester));

        bytes32 attestationID = attester.attest(schemaID, "Hello Scroll Sepola EAS!");
        
        console2.logString("You submitted the following Attestestation:");
        console2.logBytes32(attestationID);


        vm.stopBroadcast();
    }
}