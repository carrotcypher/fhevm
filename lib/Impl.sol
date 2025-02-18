// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity >=0.8.13 <0.8.20;

interface FhevmLib {
    function fheAdd(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheSub(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheMul(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheDiv(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheBitAnd(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheBitOr(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheBitXor(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheShl(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheShr(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheEq(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheNe(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheGe(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheGt(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheLe(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheLt(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheMin(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheMax(uint256 lhs, uint256 rhs, bytes1 scalarByte) external pure returns (uint256 result);

    function fheNeg(uint256 ct) external pure returns (uint256 result);

    function fheNot(uint256 ct) external pure returns (uint256 result);

    function optimisticRequire(uint256 ct) external view;

    function reencrypt(uint256 ct, uint256 publicKey) external view returns (bytes memory);

    function fhePubKey(bytes1 fromLib) external view returns (bytes memory result);

    function verifyCiphertext(bytes memory input) external pure returns (uint256 result);

    function cast(uint256 ct, bytes1 toType) external pure returns (uint256 result);

    function trivialEncrypt(uint256 ct, bytes1 toType) external pure returns (uint256 result);

    function decrypt(uint256 ct) external view returns (uint256 result);

    function fheRand(bytes1 inp) external view returns (uint256 result);
}

address constant EXT_TFHE_LIBRARY = address(93);

library Impl {
    // 32 bytes for the 'byte' type header + 48 bytes for the NaCl anonymous
    // box overhead + 4 bytes for the plaintext value.
    uint256 constant reencryptedSize = 32 + 48 + 4;

    // 32 bytes for the 'byte' header + 16553 bytes of key data.
    uint256 constant fhePubKeySize = 32 + 16553;

    function add(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheAdd(lhs, rhs, scalarByte);
    }

    function sub(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheSub(lhs, rhs, scalarByte);
    }

    function mul(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheMul(lhs, rhs, scalarByte);
    }

    function div(uint256 lhs, uint256 rhs) internal pure returns (uint256 result) {
        bytes1 scalarByte = 0x01;
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheDiv(lhs, rhs, scalarByte);
    }

    function and(uint256 lhs, uint256 rhs) internal pure returns (uint256 result) {
        bytes1 scalarByte = 0x00;
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheBitAnd(lhs, rhs, scalarByte);
    }

    function or(uint256 lhs, uint256 rhs) internal pure returns (uint256 result) {
        bytes1 scalarByte = 0x00;
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheBitOr(lhs, rhs, scalarByte);
    }

    function xor(uint256 lhs, uint256 rhs) internal pure returns (uint256 result) {
        bytes1 scalarByte = 0x00;
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheBitXor(lhs, rhs, scalarByte);
    }

    function shl(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheShl(lhs, rhs, scalarByte);
    }

    function shr(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheShr(lhs, rhs, scalarByte);
    }

    function eq(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheEq(lhs, rhs, scalarByte);
    }

    function ne(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheNe(lhs, rhs, scalarByte);
    }

    function ge(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheGe(lhs, rhs, scalarByte);
    }

    function gt(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheGt(lhs, rhs, scalarByte);
    }

    function le(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheLe(lhs, rhs, scalarByte);
    }

    function lt(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheLt(lhs, rhs, scalarByte);
    }

    function min(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheMin(lhs, rhs, scalarByte);
    }

    function max(uint256 lhs, uint256 rhs, bool scalar) internal pure returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheMax(lhs, rhs, scalarByte);
    }

    function neg(uint256 ct) internal pure returns (uint256 result) {
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheNeg(ct);
    }

    function not(uint256 ct) internal pure returns (uint256 result) {
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheNot(ct);
    }

    // If 'control's value is 'true', the result has the same value as 'ifTrue'.
    // If 'control's value is 'false', the result has the same value as 'ifFalse'.
    function cmux(uint256 control, uint256 ifTrue, uint256 ifFalse) internal pure returns (uint256 result) {
        // result = (ifTrue - ifFalse) * control + ifFalse
        uint256 subOutput = FhevmLib(address(EXT_TFHE_LIBRARY)).fheSub(ifTrue, ifFalse, bytes1(0x00));
        uint256 mulOutput = FhevmLib(address(EXT_TFHE_LIBRARY)).fheMul(control, subOutput, bytes1(0x00));
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheAdd(mulOutput, ifFalse, bytes1(0x00));
    }

    function optReq(uint256 ciphertext) internal view {
        FhevmLib(address(EXT_TFHE_LIBRARY)).optimisticRequire(ciphertext);
    }

    function reencrypt(uint256 ciphertext, bytes32 publicKey) internal view returns (bytes memory reencrypted) {
        return FhevmLib(address(EXT_TFHE_LIBRARY)).reencrypt(ciphertext, uint256(publicKey));
    }

    function fhePubKey() internal view returns (bytes memory key) {
        // Set a byte value of 1 to signal the call comes from the library.
        key = FhevmLib(address(EXT_TFHE_LIBRARY)).fhePubKey(bytes1(0x01));
    }

    function verify(bytes memory _ciphertextBytes, uint8 _toType) internal pure returns (uint256 result) {
        bytes memory input = bytes.concat(_ciphertextBytes, bytes1(_toType));
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).verifyCiphertext(input);
    }

    function cast(uint256 ciphertext, uint8 toType) internal pure returns (uint256 result) {
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).cast(ciphertext, bytes1(toType));
    }

    function trivialEncrypt(uint256 value, uint8 toType) internal pure returns (uint256 result) {
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).trivialEncrypt(value, bytes1(toType));
    }

    function decrypt(uint256 ciphertext) internal view returns (uint256 result) {
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).decrypt(ciphertext);
    }

    function rand(uint8 randType) internal view returns (uint256 result) {
        result = FhevmLib(address(EXT_TFHE_LIBRARY)).fheRand(bytes1(randType));
    }
}
