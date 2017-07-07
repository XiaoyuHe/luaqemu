-- Copyright (c) 2017 Comsecuris UG (haftungsbeschraenkt)
--[[
Capstone has been designed & implemented by Nguyen Anh Quynh <aquynh@gmail.com>

See http://www.capstone-engine.org for further information.

Copyright (c) 2013, COSEINC.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.
* Neither the name of the developer(s) nor the names of its
  contributors may be used to endorse or promote products derived from this
  software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
--]]

ffi.cdef[[
//> X86 registers
typedef enum x86_reg {
	X86_REG_INVALID = 0,
	X86_REG_AH, X86_REG_AL, X86_REG_AX, X86_REG_BH, X86_REG_BL,
	X86_REG_BP, X86_REG_BPL, X86_REG_BX, X86_REG_CH, X86_REG_CL,
	X86_REG_CS, X86_REG_CX, X86_REG_DH, X86_REG_DI, X86_REG_DIL,
	X86_REG_DL, X86_REG_DS, X86_REG_DX, X86_REG_EAX, X86_REG_EBP,
	X86_REG_EBX, X86_REG_ECX, X86_REG_EDI, X86_REG_EDX, X86_REG_EFLAGS,
	X86_REG_EIP, X86_REG_EIZ, X86_REG_ES, X86_REG_ESI, X86_REG_ESP,
	X86_REG_FPSW, X86_REG_FS, X86_REG_GS, X86_REG_IP, X86_REG_RAX,
	X86_REG_RBP, X86_REG_RBX, X86_REG_RCX, X86_REG_RDI, X86_REG_RDX,
	X86_REG_RIP, X86_REG_RIZ, X86_REG_RSI, X86_REG_RSP, X86_REG_SI,
	X86_REG_SIL, X86_REG_SP, X86_REG_SPL, X86_REG_SS, X86_REG_CR0,
	X86_REG_CR1, X86_REG_CR2, X86_REG_CR3, X86_REG_CR4, X86_REG_CR5,
	X86_REG_CR6, X86_REG_CR7, X86_REG_CR8, X86_REG_CR9, X86_REG_CR10,
	X86_REG_CR11, X86_REG_CR12, X86_REG_CR13, X86_REG_CR14, X86_REG_CR15,
	X86_REG_DR0, X86_REG_DR1, X86_REG_DR2, X86_REG_DR3, X86_REG_DR4,
	X86_REG_DR5, X86_REG_DR6, X86_REG_DR7, X86_REG_FP0, X86_REG_FP1,
	X86_REG_FP2, X86_REG_FP3, X86_REG_FP4, X86_REG_FP5, X86_REG_FP6, X86_REG_FP7,
	X86_REG_K0, X86_REG_K1, X86_REG_K2, X86_REG_K3, X86_REG_K4,
	X86_REG_K5, X86_REG_K6, X86_REG_K7, X86_REG_MM0, X86_REG_MM1,
	X86_REG_MM2, X86_REG_MM3, X86_REG_MM4, X86_REG_MM5, X86_REG_MM6,
	X86_REG_MM7, X86_REG_R8, X86_REG_R9, X86_REG_R10, X86_REG_R11,
	X86_REG_R12, X86_REG_R13, X86_REG_R14, X86_REG_R15,
	X86_REG_ST0, X86_REG_ST1, X86_REG_ST2, X86_REG_ST3,
	X86_REG_ST4, X86_REG_ST5, X86_REG_ST6, X86_REG_ST7,
	X86_REG_XMM0, X86_REG_XMM1, X86_REG_XMM2, X86_REG_XMM3, X86_REG_XMM4,
	X86_REG_XMM5, X86_REG_XMM6, X86_REG_XMM7, X86_REG_XMM8, X86_REG_XMM9,
	X86_REG_XMM10, X86_REG_XMM11, X86_REG_XMM12, X86_REG_XMM13, X86_REG_XMM14,
	X86_REG_XMM15, X86_REG_XMM16, X86_REG_XMM17, X86_REG_XMM18, X86_REG_XMM19,
	X86_REG_XMM20, X86_REG_XMM21, X86_REG_XMM22, X86_REG_XMM23, X86_REG_XMM24,
	X86_REG_XMM25, X86_REG_XMM26, X86_REG_XMM27, X86_REG_XMM28, X86_REG_XMM29,
	X86_REG_XMM30, X86_REG_XMM31, X86_REG_YMM0, X86_REG_YMM1, X86_REG_YMM2,
	X86_REG_YMM3, X86_REG_YMM4, X86_REG_YMM5, X86_REG_YMM6, X86_REG_YMM7,
	X86_REG_YMM8, X86_REG_YMM9, X86_REG_YMM10, X86_REG_YMM11, X86_REG_YMM12,
	X86_REG_YMM13, X86_REG_YMM14, X86_REG_YMM15, X86_REG_YMM16, X86_REG_YMM17,
	X86_REG_YMM18, X86_REG_YMM19, X86_REG_YMM20, X86_REG_YMM21, X86_REG_YMM22,
	X86_REG_YMM23, X86_REG_YMM24, X86_REG_YMM25, X86_REG_YMM26, X86_REG_YMM27,
	X86_REG_YMM28, X86_REG_YMM29, X86_REG_YMM30, X86_REG_YMM31, X86_REG_ZMM0,
	X86_REG_ZMM1, X86_REG_ZMM2, X86_REG_ZMM3, X86_REG_ZMM4, X86_REG_ZMM5,
	X86_REG_ZMM6, X86_REG_ZMM7, X86_REG_ZMM8, X86_REG_ZMM9, X86_REG_ZMM10,
	X86_REG_ZMM11, X86_REG_ZMM12, X86_REG_ZMM13, X86_REG_ZMM14, X86_REG_ZMM15,
	X86_REG_ZMM16, X86_REG_ZMM17, X86_REG_ZMM18, X86_REG_ZMM19, X86_REG_ZMM20,
	X86_REG_ZMM21, X86_REG_ZMM22, X86_REG_ZMM23, X86_REG_ZMM24, X86_REG_ZMM25,
	X86_REG_ZMM26, X86_REG_ZMM27, X86_REG_ZMM28, X86_REG_ZMM29, X86_REG_ZMM30,
	X86_REG_ZMM31, X86_REG_R8B, X86_REG_R9B, X86_REG_R10B, X86_REG_R11B,
	X86_REG_R12B, X86_REG_R13B, X86_REG_R14B, X86_REG_R15B, X86_REG_R8D,
	X86_REG_R9D, X86_REG_R10D, X86_REG_R11D, X86_REG_R12D, X86_REG_R13D,
	X86_REG_R14D, X86_REG_R15D, X86_REG_R8W, X86_REG_R9W, X86_REG_R10W,
	X86_REG_R11W, X86_REG_R12W, X86_REG_R13W, X86_REG_R14W, X86_REG_R15W,

	X86_REG_ENDING		// <-- mark the end of the list of registers
} x86_reg;

//> Operand type for instruction's operands
typedef enum x86_op_type {
	X86_OP_INVALID = 0, // = CS_OP_INVALID (Uninitialized).
	X86_OP_REG, // = CS_OP_REG (Register operand).
	X86_OP_IMM, // = CS_OP_IMM (Immediate operand).
	X86_OP_MEM, // = CS_OP_MEM (Memory operand).
	X86_OP_FP,  //  = CS_OP_FP  (Floating-Point operand).
} x86_op_type;

//> AVX broadcast type
typedef enum x86_avx_bcast {
	X86_AVX_BCAST_INVALID = 0,	// Uninitialized.
	X86_AVX_BCAST_2,	// AVX512 broadcast type {1to2}
	X86_AVX_BCAST_4,	// AVX512 broadcast type {1to4}
	X86_AVX_BCAST_8,	// AVX512 broadcast type {1to8}
	X86_AVX_BCAST_16,	// AVX512 broadcast type {1to16}
} x86_avx_bcast;

//> SSE Code Condition type
typedef enum x86_sse_cc {
	X86_SSE_CC_INVALID = 0,	// Uninitialized.
	X86_SSE_CC_EQ,
	X86_SSE_CC_LT,
	X86_SSE_CC_LE,
	X86_SSE_CC_UNORD,
	X86_SSE_CC_NEQ,
	X86_SSE_CC_NLT,
	X86_SSE_CC_NLE,
	X86_SSE_CC_ORD,
	X86_SSE_CC_EQ_UQ,
	X86_SSE_CC_NGE,
	X86_SSE_CC_NGT,
	X86_SSE_CC_FALSE,
	X86_SSE_CC_NEQ_OQ,
	X86_SSE_CC_GE,
	X86_SSE_CC_GT,
	X86_SSE_CC_TRUE,
} x86_sse_cc;

//> AVX Code Condition type
typedef enum x86_avx_cc {
	X86_AVX_CC_INVALID = 0,	// Uninitialized.
	X86_AVX_CC_EQ,
	X86_AVX_CC_LT,
	X86_AVX_CC_LE,
	X86_AVX_CC_UNORD,
	X86_AVX_CC_NEQ,
	X86_AVX_CC_NLT,
	X86_AVX_CC_NLE,
	X86_AVX_CC_ORD,
	X86_AVX_CC_EQ_UQ,
	X86_AVX_CC_NGE,
	X86_AVX_CC_NGT,
	X86_AVX_CC_FALSE,
	X86_AVX_CC_NEQ_OQ,
	X86_AVX_CC_GE,
	X86_AVX_CC_GT,
	X86_AVX_CC_TRUE,
	X86_AVX_CC_EQ_OS,
	X86_AVX_CC_LT_OQ,
	X86_AVX_CC_LE_OQ,
	X86_AVX_CC_UNORD_S,
	X86_AVX_CC_NEQ_US,
	X86_AVX_CC_NLT_UQ,
	X86_AVX_CC_NLE_UQ,
	X86_AVX_CC_ORD_S,
	X86_AVX_CC_EQ_US,
	X86_AVX_CC_NGE_UQ,
	X86_AVX_CC_NGT_UQ,
	X86_AVX_CC_FALSE_OS,
	X86_AVX_CC_NEQ_OS,
	X86_AVX_CC_GE_OQ,
	X86_AVX_CC_GT_OQ,
	X86_AVX_CC_TRUE_US,
} x86_avx_cc;

//> AVX static rounding mode type
typedef enum x86_avx_rm {
	X86_AVX_RM_INVALID = 0,	// Uninitialized.
	X86_AVX_RM_RN,	// Round to nearest
	X86_AVX_RM_RD,	// Round down
	X86_AVX_RM_RU,	// Round up
	X86_AVX_RM_RZ,	// Round toward zero
} x86_avx_rm;

//> Instruction prefixes - to be used in cs_x86.prefix[]
typedef enum x86_prefix {
	X86_PREFIX_LOCK		= 	0xf0,	// lock (cs_x86.prefix[0]
	X86_PREFIX_REP		= 	0xf3,	// rep (cs_x86.prefix[0]
	X86_PREFIX_REPNE	= 	0xf2,	// repne (cs_x86.prefix[0]

	X86_PREFIX_CS		= 	0x2e,	// segment override CS (cs_x86.prefix[1]
	X86_PREFIX_SS		= 	0x36,	// segment override SS (cs_x86.prefix[1]
	X86_PREFIX_DS		= 	0x3e,	// segment override DS (cs_x86.prefix[1]
	X86_PREFIX_ES		= 	0x26,	// segment override ES (cs_x86.prefix[1]
	X86_PREFIX_FS		= 	0x64,	// segment override FS (cs_x86.prefix[1]
	X86_PREFIX_GS		= 	0x65,	// segment override GS (cs_x86.prefix[1]

	X86_PREFIX_OPSIZE	=	0x66,	// operand-size override (cs_x86.prefix[2]
	X86_PREFIX_ADDRSIZE	=	0x67,	// address-size override (cs_x86.prefix[3]
} x86_prefix;

// Instruction's operand referring to memory
// This is associated with X86_OP_MEM operand type above
typedef struct x86_op_mem {
	unsigned int segment; // segment register (or X86_REG_INVALID if irrelevant)
	unsigned int base;	// base register (or X86_REG_INVALID if irrelevant)
	unsigned int index;	// index register (or X86_REG_INVALID if irrelevant)
	int scale;	// scale for index register
	int64_t disp;	// displacement value
} x86_op_mem;

// Instruction operand
typedef struct cs_x86_op {
		x86_op_type type;	// operand type
		union {
			x86_reg reg;	// register value for REG operand
			int64_t imm;		// immediate value for IMM operand
			double fp;		// floating point value for FP operand
			x86_op_mem mem;		// base/index/scale/disp value for MEM operand
		};

		// size of this operand (in bytes).
		uint8_t size;

		// AVX broadcast type, or 0 if irrelevant
		x86_avx_bcast avx_bcast;

		// AVX zero opmask {z}
		bool avx_zero_opmask;
} cs_x86_op;

// Instruction structure
typedef struct cs_x86 {
	// Instruction prefix, which can be up to 4 bytes.
	// A prefix byte gets value 0 when irrelevant.
	// prefix[0] indicates REP/REPNE/LOCK prefix (See X86_PREFIX_REP/REPNE/LOCK above)
	// prefix[1] indicates segment override (irrelevant for x86_64):
	// See X86_PREFIX_CS/SS/DS/ES/FS/GS above.
	// prefix[2] indicates operand-size override (X86_PREFIX_OPSIZE)
	// prefix[3] indicates address-size override (X86_PREFIX_ADDRSIZE)
	uint8_t prefix[4];

	// Instruction opcode, which can be from 1 to 4 bytes in size.
	// This contains VEX opcode as well.
	// An trailing opcode byte gets value 0 when irrelevant.
	uint8_t opcode[4];

	// REX prefix: only a non-zero value is relevant for x86_64
	uint8_t rex;

	// Address size, which can be overridden with above prefix[5].
	uint8_t addr_size;

	// ModR/M byte
	uint8_t modrm;

	// SIB value, or 0 when irrelevant.
	uint8_t sib;

	// Displacement value, or 0 when irrelevant.
	int32_t disp;

	/* SIB state */
	// SIB index register, or X86_REG_INVALID when irrelevant.
	x86_reg sib_index;
	// SIB scale. only applicable if sib_index is relevant.
	int8_t sib_scale;
	// SIB base register, or X86_REG_INVALID when irrelevant.
	x86_reg sib_base;

	// SSE Code Condition
	x86_sse_cc sse_cc;

	// AVX Code Condition
	x86_avx_cc avx_cc;

	// AVX Suppress all Exception
	bool avx_sae;

	// AVX static rounding mode
	x86_avx_rm avx_rm;

	// Number of operands of this instruction,
	// or 0 when instruction has no operand.
	uint8_t op_count;

	cs_x86_op operands[8];	// operands for this instruction.
} cs_x86;

//> X86 instructions
typedef enum x86_insn {
	X86_INS_INVALID = 0,

	X86_INS_AAA,
	X86_INS_AAD,
	X86_INS_AAM,
	X86_INS_AAS,
	X86_INS_FABS,
	X86_INS_ADC,
	X86_INS_ADCX,
	X86_INS_ADD,
	X86_INS_ADDPD,
	X86_INS_ADDPS,
	X86_INS_ADDSD,
	X86_INS_ADDSS,
	X86_INS_ADDSUBPD,
	X86_INS_ADDSUBPS,
	X86_INS_FADD,
	X86_INS_FIADD,
	X86_INS_FADDP,
	X86_INS_ADOX,
	X86_INS_AESDECLAST,
	X86_INS_AESDEC,
	X86_INS_AESENCLAST,
	X86_INS_AESENC,
	X86_INS_AESIMC,
	X86_INS_AESKEYGENASSIST,
	X86_INS_AND,
	X86_INS_ANDN,
	X86_INS_ANDNPD,
	X86_INS_ANDNPS,
	X86_INS_ANDPD,
	X86_INS_ANDPS,
	X86_INS_ARPL,
	X86_INS_BEXTR,
	X86_INS_BLCFILL,
	X86_INS_BLCI,
	X86_INS_BLCIC,
	X86_INS_BLCMSK,
	X86_INS_BLCS,
	X86_INS_BLENDPD,
	X86_INS_BLENDPS,
	X86_INS_BLENDVPD,
	X86_INS_BLENDVPS,
	X86_INS_BLSFILL,
	X86_INS_BLSI,
	X86_INS_BLSIC,
	X86_INS_BLSMSK,
	X86_INS_BLSR,
	X86_INS_BOUND,
	X86_INS_BSF,
	X86_INS_BSR,
	X86_INS_BSWAP,
	X86_INS_BT,
	X86_INS_BTC,
	X86_INS_BTR,
	X86_INS_BTS,
	X86_INS_BZHI,
	X86_INS_CALL,
	X86_INS_CBW,
	X86_INS_CDQ,
	X86_INS_CDQE,
	X86_INS_FCHS,
	X86_INS_CLAC,
	X86_INS_CLC,
	X86_INS_CLD,
	X86_INS_CLFLUSH,
	X86_INS_CLGI,
	X86_INS_CLI,
	X86_INS_CLTS,
	X86_INS_CMC,
	X86_INS_CMOVA,
	X86_INS_CMOVAE,
	X86_INS_CMOVB,
	X86_INS_CMOVBE,
	X86_INS_FCMOVBE,
	X86_INS_FCMOVB,
	X86_INS_CMOVE,
	X86_INS_FCMOVE,
	X86_INS_CMOVG,
	X86_INS_CMOVGE,
	X86_INS_CMOVL,
	X86_INS_CMOVLE,
	X86_INS_FCMOVNBE,
	X86_INS_FCMOVNB,
	X86_INS_CMOVNE,
	X86_INS_FCMOVNE,
	X86_INS_CMOVNO,
	X86_INS_CMOVNP,
	X86_INS_FCMOVNU,
	X86_INS_CMOVNS,
	X86_INS_CMOVO,
	X86_INS_CMOVP,
	X86_INS_FCMOVU,
	X86_INS_CMOVS,
	X86_INS_CMP,
	X86_INS_CMPPD,
	X86_INS_CMPPS,
	X86_INS_CMPSB,
	X86_INS_CMPSD,
	X86_INS_CMPSQ,
	X86_INS_CMPSS,
	X86_INS_CMPSW,
	X86_INS_CMPXCHG16B,
	X86_INS_CMPXCHG,
	X86_INS_CMPXCHG8B,
	X86_INS_COMISD,
	X86_INS_COMISS,
	X86_INS_FCOMP,
	X86_INS_FCOMPI,
	X86_INS_FCOMI,
	X86_INS_FCOM,
	X86_INS_FCOS,
	X86_INS_CPUID,
	X86_INS_CQO,
	X86_INS_CRC32,
	X86_INS_CVTDQ2PD,
	X86_INS_CVTDQ2PS,
	X86_INS_CVTPD2DQ,
	X86_INS_CVTPD2PS,
	X86_INS_CVTPS2DQ,
	X86_INS_CVTPS2PD,
	X86_INS_CVTSD2SI,
	X86_INS_CVTSD2SS,
	X86_INS_CVTSI2SD,
	X86_INS_CVTSI2SS,
	X86_INS_CVTSS2SD,
	X86_INS_CVTSS2SI,
	X86_INS_CVTTPD2DQ,
	X86_INS_CVTTPS2DQ,
	X86_INS_CVTTSD2SI,
	X86_INS_CVTTSS2SI,
	X86_INS_CWD,
	X86_INS_CWDE,
	X86_INS_DAA,
	X86_INS_DAS,
	X86_INS_DATA16,
	X86_INS_DEC,
	X86_INS_DIV,
	X86_INS_DIVPD,
	X86_INS_DIVPS,
	X86_INS_FDIVR,
	X86_INS_FIDIVR,
	X86_INS_FDIVRP,
	X86_INS_DIVSD,
	X86_INS_DIVSS,
	X86_INS_FDIV,
	X86_INS_FIDIV,
	X86_INS_FDIVP,
	X86_INS_DPPD,
	X86_INS_DPPS,
	X86_INS_RET,
	X86_INS_ENCLS,
	X86_INS_ENCLU,
	X86_INS_ENTER,
	X86_INS_EXTRACTPS,
	X86_INS_EXTRQ,
	X86_INS_F2XM1,
	X86_INS_LCALL,
	X86_INS_LJMP,
	X86_INS_FBLD,
	X86_INS_FBSTP,
	X86_INS_FCOMPP,
	X86_INS_FDECSTP,
	X86_INS_FEMMS,
	X86_INS_FFREE,
	X86_INS_FICOM,
	X86_INS_FICOMP,
	X86_INS_FINCSTP,
	X86_INS_FLDCW,
	X86_INS_FLDENV,
	X86_INS_FLDL2E,
	X86_INS_FLDL2T,
	X86_INS_FLDLG2,
	X86_INS_FLDLN2,
	X86_INS_FLDPI,
	X86_INS_FNCLEX,
	X86_INS_FNINIT,
	X86_INS_FNOP,
	X86_INS_FNSTCW,
	X86_INS_FNSTSW,
	X86_INS_FPATAN,
	X86_INS_FPREM,
	X86_INS_FPREM1,
	X86_INS_FPTAN,
	X86_INS_FRNDINT,
	X86_INS_FRSTOR,
	X86_INS_FNSAVE,
	X86_INS_FSCALE,
	X86_INS_FSETPM,
	X86_INS_FSINCOS,
	X86_INS_FNSTENV,
	X86_INS_FXAM,
	X86_INS_FXRSTOR,
	X86_INS_FXRSTOR64,
	X86_INS_FXSAVE,
	X86_INS_FXSAVE64,
	X86_INS_FXTRACT,
	X86_INS_FYL2X,
	X86_INS_FYL2XP1,
	X86_INS_MOVAPD,
	X86_INS_MOVAPS,
	X86_INS_ORPD,
	X86_INS_ORPS,
	X86_INS_VMOVAPD,
	X86_INS_VMOVAPS,
	X86_INS_XORPD,
	X86_INS_XORPS,
	X86_INS_GETSEC,
	X86_INS_HADDPD,
	X86_INS_HADDPS,
	X86_INS_HLT,
	X86_INS_HSUBPD,
	X86_INS_HSUBPS,
	X86_INS_IDIV,
	X86_INS_FILD,
	X86_INS_IMUL,
	X86_INS_IN,
	X86_INS_INC,
	X86_INS_INSB,
	X86_INS_INSERTPS,
	X86_INS_INSERTQ,
	X86_INS_INSD,
	X86_INS_INSW,
	X86_INS_INT,
	X86_INS_INT1,
	X86_INS_INT3,
	X86_INS_INTO,
	X86_INS_INVD,
	X86_INS_INVEPT,
	X86_INS_INVLPG,
	X86_INS_INVLPGA,
	X86_INS_INVPCID,
	X86_INS_INVVPID,
	X86_INS_IRET,
	X86_INS_IRETD,
	X86_INS_IRETQ,
	X86_INS_FISTTP,
	X86_INS_FIST,
	X86_INS_FISTP,
	X86_INS_UCOMISD,
	X86_INS_UCOMISS,
	X86_INS_VCMP,
	X86_INS_VCOMISD,
	X86_INS_VCOMISS,
	X86_INS_VCVTSD2SS,
	X86_INS_VCVTSI2SD,
	X86_INS_VCVTSI2SS,
	X86_INS_VCVTSS2SD,
	X86_INS_VCVTTSD2SI,
	X86_INS_VCVTTSD2USI,
	X86_INS_VCVTTSS2SI,
	X86_INS_VCVTTSS2USI,
	X86_INS_VCVTUSI2SD,
	X86_INS_VCVTUSI2SS,
	X86_INS_VUCOMISD,
	X86_INS_VUCOMISS,
	X86_INS_JAE,
	X86_INS_JA,
	X86_INS_JBE,
	X86_INS_JB,
	X86_INS_JCXZ,
	X86_INS_JECXZ,
	X86_INS_JE,
	X86_INS_JGE,
	X86_INS_JG,
	X86_INS_JLE,
	X86_INS_JL,
	X86_INS_JMP,
	X86_INS_JNE,
	X86_INS_JNO,
	X86_INS_JNP,
	X86_INS_JNS,
	X86_INS_JO,
	X86_INS_JP,
	X86_INS_JRCXZ,
	X86_INS_JS,
	X86_INS_KANDB,
	X86_INS_KANDD,
	X86_INS_KANDNB,
	X86_INS_KANDND,
	X86_INS_KANDNQ,
	X86_INS_KANDNW,
	X86_INS_KANDQ,
	X86_INS_KANDW,
	X86_INS_KMOVB,
	X86_INS_KMOVD,
	X86_INS_KMOVQ,
	X86_INS_KMOVW,
	X86_INS_KNOTB,
	X86_INS_KNOTD,
	X86_INS_KNOTQ,
	X86_INS_KNOTW,
	X86_INS_KORB,
	X86_INS_KORD,
	X86_INS_KORQ,
	X86_INS_KORTESTW,
	X86_INS_KORW,
	X86_INS_KSHIFTLW,
	X86_INS_KSHIFTRW,
	X86_INS_KUNPCKBW,
	X86_INS_KXNORB,
	X86_INS_KXNORD,
	X86_INS_KXNORQ,
	X86_INS_KXNORW,
	X86_INS_KXORB,
	X86_INS_KXORD,
	X86_INS_KXORQ,
	X86_INS_KXORW,
	X86_INS_LAHF,
	X86_INS_LAR,
	X86_INS_LDDQU,
	X86_INS_LDMXCSR,
	X86_INS_LDS,
	X86_INS_FLDZ,
	X86_INS_FLD1,
	X86_INS_FLD,
	X86_INS_LEA,
	X86_INS_LEAVE,
	X86_INS_LES,
	X86_INS_LFENCE,
	X86_INS_LFS,
	X86_INS_LGDT,
	X86_INS_LGS,
	X86_INS_LIDT,
	X86_INS_LLDT,
	X86_INS_LMSW,
	X86_INS_OR,
	X86_INS_SUB,
	X86_INS_XOR,
	X86_INS_LODSB,
	X86_INS_LODSD,
	X86_INS_LODSQ,
	X86_INS_LODSW,
	X86_INS_LOOP,
	X86_INS_LOOPE,
	X86_INS_LOOPNE,
	X86_INS_RETF,
	X86_INS_RETFQ,
	X86_INS_LSL,
	X86_INS_LSS,
	X86_INS_LTR,
	X86_INS_XADD,
	X86_INS_LZCNT,
	X86_INS_MASKMOVDQU,
	X86_INS_MAXPD,
	X86_INS_MAXPS,
	X86_INS_MAXSD,
	X86_INS_MAXSS,
	X86_INS_MFENCE,
	X86_INS_MINPD,
	X86_INS_MINPS,
	X86_INS_MINSD,
	X86_INS_MINSS,
	X86_INS_CVTPD2PI,
	X86_INS_CVTPI2PD,
	X86_INS_CVTPI2PS,
	X86_INS_CVTPS2PI,
	X86_INS_CVTTPD2PI,
	X86_INS_CVTTPS2PI,
	X86_INS_EMMS,
	X86_INS_MASKMOVQ,
	X86_INS_MOVD,
	X86_INS_MOVDQ2Q,
	X86_INS_MOVNTQ,
	X86_INS_MOVQ2DQ,
	X86_INS_MOVQ,
	X86_INS_PABSB,
	X86_INS_PABSD,
	X86_INS_PABSW,
	X86_INS_PACKSSDW,
	X86_INS_PACKSSWB,
	X86_INS_PACKUSWB,
	X86_INS_PADDB,
	X86_INS_PADDD,
	X86_INS_PADDQ,
	X86_INS_PADDSB,
	X86_INS_PADDSW,
	X86_INS_PADDUSB,
	X86_INS_PADDUSW,
	X86_INS_PADDW,
	X86_INS_PALIGNR,
	X86_INS_PANDN,
	X86_INS_PAND,
	X86_INS_PAVGB,
	X86_INS_PAVGW,
	X86_INS_PCMPEQB,
	X86_INS_PCMPEQD,
	X86_INS_PCMPEQW,
	X86_INS_PCMPGTB,
	X86_INS_PCMPGTD,
	X86_INS_PCMPGTW,
	X86_INS_PEXTRW,
	X86_INS_PHADDSW,
	X86_INS_PHADDW,
	X86_INS_PHADDD,
	X86_INS_PHSUBD,
	X86_INS_PHSUBSW,
	X86_INS_PHSUBW,
	X86_INS_PINSRW,
	X86_INS_PMADDUBSW,
	X86_INS_PMADDWD,
	X86_INS_PMAXSW,
	X86_INS_PMAXUB,
	X86_INS_PMINSW,
	X86_INS_PMINUB,
	X86_INS_PMOVMSKB,
	X86_INS_PMULHRSW,
	X86_INS_PMULHUW,
	X86_INS_PMULHW,
	X86_INS_PMULLW,
	X86_INS_PMULUDQ,
	X86_INS_POR,
	X86_INS_PSADBW,
	X86_INS_PSHUFB,
	X86_INS_PSHUFW,
	X86_INS_PSIGNB,
	X86_INS_PSIGND,
	X86_INS_PSIGNW,
	X86_INS_PSLLD,
	X86_INS_PSLLQ,
	X86_INS_PSLLW,
	X86_INS_PSRAD,
	X86_INS_PSRAW,
	X86_INS_PSRLD,
	X86_INS_PSRLQ,
	X86_INS_PSRLW,
	X86_INS_PSUBB,
	X86_INS_PSUBD,
	X86_INS_PSUBQ,
	X86_INS_PSUBSB,
	X86_INS_PSUBSW,
	X86_INS_PSUBUSB,
	X86_INS_PSUBUSW,
	X86_INS_PSUBW,
	X86_INS_PUNPCKHBW,
	X86_INS_PUNPCKHDQ,
	X86_INS_PUNPCKHWD,
	X86_INS_PUNPCKLBW,
	X86_INS_PUNPCKLDQ,
	X86_INS_PUNPCKLWD,
	X86_INS_PXOR,
	X86_INS_MONITOR,
	X86_INS_MONTMUL,
	X86_INS_MOV,
	X86_INS_MOVABS,
	X86_INS_MOVBE,
	X86_INS_MOVDDUP,
	X86_INS_MOVDQA,
	X86_INS_MOVDQU,
	X86_INS_MOVHLPS,
	X86_INS_MOVHPD,
	X86_INS_MOVHPS,
	X86_INS_MOVLHPS,
	X86_INS_MOVLPD,
	X86_INS_MOVLPS,
	X86_INS_MOVMSKPD,
	X86_INS_MOVMSKPS,
	X86_INS_MOVNTDQA,
	X86_INS_MOVNTDQ,
	X86_INS_MOVNTI,
	X86_INS_MOVNTPD,
	X86_INS_MOVNTPS,
	X86_INS_MOVNTSD,
	X86_INS_MOVNTSS,
	X86_INS_MOVSB,
	X86_INS_MOVSD,
	X86_INS_MOVSHDUP,
	X86_INS_MOVSLDUP,
	X86_INS_MOVSQ,
	X86_INS_MOVSS,
	X86_INS_MOVSW,
	X86_INS_MOVSX,
	X86_INS_MOVSXD,
	X86_INS_MOVUPD,
	X86_INS_MOVUPS,
	X86_INS_MOVZX,
	X86_INS_MPSADBW,
	X86_INS_MUL,
	X86_INS_MULPD,
	X86_INS_MULPS,
	X86_INS_MULSD,
	X86_INS_MULSS,
	X86_INS_MULX,
	X86_INS_FMUL,
	X86_INS_FIMUL,
	X86_INS_FMULP,
	X86_INS_MWAIT,
	X86_INS_NEG,
	X86_INS_NOP,
	X86_INS_NOT,
	X86_INS_OUT,
	X86_INS_OUTSB,
	X86_INS_OUTSD,
	X86_INS_OUTSW,
	X86_INS_PACKUSDW,
	X86_INS_PAUSE,
	X86_INS_PAVGUSB,
	X86_INS_PBLENDVB,
	X86_INS_PBLENDW,
	X86_INS_PCLMULQDQ,
	X86_INS_PCMPEQQ,
	X86_INS_PCMPESTRI,
	X86_INS_PCMPESTRM,
	X86_INS_PCMPGTQ,
	X86_INS_PCMPISTRI,
	X86_INS_PCMPISTRM,
	X86_INS_PDEP,
	X86_INS_PEXT,
	X86_INS_PEXTRB,
	X86_INS_PEXTRD,
	X86_INS_PEXTRQ,
	X86_INS_PF2ID,
	X86_INS_PF2IW,
	X86_INS_PFACC,
	X86_INS_PFADD,
	X86_INS_PFCMPEQ,
	X86_INS_PFCMPGE,
	X86_INS_PFCMPGT,
	X86_INS_PFMAX,
	X86_INS_PFMIN,
	X86_INS_PFMUL,
	X86_INS_PFNACC,
	X86_INS_PFPNACC,
	X86_INS_PFRCPIT1,
	X86_INS_PFRCPIT2,
	X86_INS_PFRCP,
	X86_INS_PFRSQIT1,
	X86_INS_PFRSQRT,
	X86_INS_PFSUBR,
	X86_INS_PFSUB,
	X86_INS_PHMINPOSUW,
	X86_INS_PI2FD,
	X86_INS_PI2FW,
	X86_INS_PINSRB,
	X86_INS_PINSRD,
	X86_INS_PINSRQ,
	X86_INS_PMAXSB,
	X86_INS_PMAXSD,
	X86_INS_PMAXUD,
	X86_INS_PMAXUW,
	X86_INS_PMINSB,
	X86_INS_PMINSD,
	X86_INS_PMINUD,
	X86_INS_PMINUW,
	X86_INS_PMOVSXBD,
	X86_INS_PMOVSXBQ,
	X86_INS_PMOVSXBW,
	X86_INS_PMOVSXDQ,
	X86_INS_PMOVSXWD,
	X86_INS_PMOVSXWQ,
	X86_INS_PMOVZXBD,
	X86_INS_PMOVZXBQ,
	X86_INS_PMOVZXBW,
	X86_INS_PMOVZXDQ,
	X86_INS_PMOVZXWD,
	X86_INS_PMOVZXWQ,
	X86_INS_PMULDQ,
	X86_INS_PMULHRW,
	X86_INS_PMULLD,
	X86_INS_POP,
	X86_INS_POPAW,
	X86_INS_POPAL,
	X86_INS_POPCNT,
	X86_INS_POPF,
	X86_INS_POPFD,
	X86_INS_POPFQ,
	X86_INS_PREFETCH,
	X86_INS_PREFETCHNTA,
	X86_INS_PREFETCHT0,
	X86_INS_PREFETCHT1,
	X86_INS_PREFETCHT2,
	X86_INS_PREFETCHW,
	X86_INS_PSHUFD,
	X86_INS_PSHUFHW,
	X86_INS_PSHUFLW,
	X86_INS_PSLLDQ,
	X86_INS_PSRLDQ,
	X86_INS_PSWAPD,
	X86_INS_PTEST,
	X86_INS_PUNPCKHQDQ,
	X86_INS_PUNPCKLQDQ,
	X86_INS_PUSH,
	X86_INS_PUSHAW,
	X86_INS_PUSHAL,
	X86_INS_PUSHF,
	X86_INS_PUSHFD,
	X86_INS_PUSHFQ,
	X86_INS_RCL,
	X86_INS_RCPPS,
	X86_INS_RCPSS,
	X86_INS_RCR,
	X86_INS_RDFSBASE,
	X86_INS_RDGSBASE,
	X86_INS_RDMSR,
	X86_INS_RDPMC,
	X86_INS_RDRAND,
	X86_INS_RDSEED,
	X86_INS_RDTSC,
	X86_INS_RDTSCP,
	X86_INS_ROL,
	X86_INS_ROR,
	X86_INS_RORX,
	X86_INS_ROUNDPD,
	X86_INS_ROUNDPS,
	X86_INS_ROUNDSD,
	X86_INS_ROUNDSS,
	X86_INS_RSM,
	X86_INS_RSQRTPS,
	X86_INS_RSQRTSS,
	X86_INS_SAHF,
	X86_INS_SAL,
	X86_INS_SALC,
	X86_INS_SAR,
	X86_INS_SARX,
	X86_INS_SBB,
	X86_INS_SCASB,
	X86_INS_SCASD,
	X86_INS_SCASQ,
	X86_INS_SCASW,
	X86_INS_SETAE,
	X86_INS_SETA,
	X86_INS_SETBE,
	X86_INS_SETB,
	X86_INS_SETE,
	X86_INS_SETGE,
	X86_INS_SETG,
	X86_INS_SETLE,
	X86_INS_SETL,
	X86_INS_SETNE,
	X86_INS_SETNO,
	X86_INS_SETNP,
	X86_INS_SETNS,
	X86_INS_SETO,
	X86_INS_SETP,
	X86_INS_SETS,
	X86_INS_SFENCE,
	X86_INS_SGDT,
	X86_INS_SHA1MSG1,
	X86_INS_SHA1MSG2,
	X86_INS_SHA1NEXTE,
	X86_INS_SHA1RNDS4,
	X86_INS_SHA256MSG1,
	X86_INS_SHA256MSG2,
	X86_INS_SHA256RNDS2,
	X86_INS_SHL,
	X86_INS_SHLD,
	X86_INS_SHLX,
	X86_INS_SHR,
	X86_INS_SHRD,
	X86_INS_SHRX,
	X86_INS_SHUFPD,
	X86_INS_SHUFPS,
	X86_INS_SIDT,
	X86_INS_FSIN,
	X86_INS_SKINIT,
	X86_INS_SLDT,
	X86_INS_SMSW,
	X86_INS_SQRTPD,
	X86_INS_SQRTPS,
	X86_INS_SQRTSD,
	X86_INS_SQRTSS,
	X86_INS_FSQRT,
	X86_INS_STAC,
	X86_INS_STC,
	X86_INS_STD,
	X86_INS_STGI,
	X86_INS_STI,
	X86_INS_STMXCSR,
	X86_INS_STOSB,
	X86_INS_STOSD,
	X86_INS_STOSQ,
	X86_INS_STOSW,
	X86_INS_STR,
	X86_INS_FST,
	X86_INS_FSTP,
	X86_INS_FSTPNCE,
	X86_INS_SUBPD,
	X86_INS_SUBPS,
	X86_INS_FSUBR,
	X86_INS_FISUBR,
	X86_INS_FSUBRP,
	X86_INS_SUBSD,
	X86_INS_SUBSS,
	X86_INS_FSUB,
	X86_INS_FISUB,
	X86_INS_FSUBP,
	X86_INS_SWAPGS,
	X86_INS_SYSCALL,
	X86_INS_SYSENTER,
	X86_INS_SYSEXIT,
	X86_INS_SYSRET,
	X86_INS_T1MSKC,
	X86_INS_TEST,
	X86_INS_UD2,
	X86_INS_FTST,
	X86_INS_TZCNT,
	X86_INS_TZMSK,
	X86_INS_FUCOMPI,
	X86_INS_FUCOMI,
	X86_INS_FUCOMPP,
	X86_INS_FUCOMP,
	X86_INS_FUCOM,
	X86_INS_UD2B,
	X86_INS_UNPCKHPD,
	X86_INS_UNPCKHPS,
	X86_INS_UNPCKLPD,
	X86_INS_UNPCKLPS,
	X86_INS_VADDPD,
	X86_INS_VADDPS,
	X86_INS_VADDSD,
	X86_INS_VADDSS,
	X86_INS_VADDSUBPD,
	X86_INS_VADDSUBPS,
	X86_INS_VAESDECLAST,
	X86_INS_VAESDEC,
	X86_INS_VAESENCLAST,
	X86_INS_VAESENC,
	X86_INS_VAESIMC,
	X86_INS_VAESKEYGENASSIST,
	X86_INS_VALIGND,
	X86_INS_VALIGNQ,
	X86_INS_VANDNPD,
	X86_INS_VANDNPS,
	X86_INS_VANDPD,
	X86_INS_VANDPS,
	X86_INS_VBLENDMPD,
	X86_INS_VBLENDMPS,
	X86_INS_VBLENDPD,
	X86_INS_VBLENDPS,
	X86_INS_VBLENDVPD,
	X86_INS_VBLENDVPS,
	X86_INS_VBROADCASTF128,
	X86_INS_VBROADCASTI128,
	X86_INS_VBROADCASTI32X4,
	X86_INS_VBROADCASTI64X4,
	X86_INS_VBROADCASTSD,
	X86_INS_VBROADCASTSS,
	X86_INS_VCMPPD,
	X86_INS_VCMPPS,
	X86_INS_VCMPSD,
	X86_INS_VCMPSS,
	X86_INS_VCVTDQ2PD,
	X86_INS_VCVTDQ2PS,
	X86_INS_VCVTPD2DQX,
	X86_INS_VCVTPD2DQ,
	X86_INS_VCVTPD2PSX,
	X86_INS_VCVTPD2PS,
	X86_INS_VCVTPD2UDQ,
	X86_INS_VCVTPH2PS,
	X86_INS_VCVTPS2DQ,
	X86_INS_VCVTPS2PD,
	X86_INS_VCVTPS2PH,
	X86_INS_VCVTPS2UDQ,
	X86_INS_VCVTSD2SI,
	X86_INS_VCVTSD2USI,
	X86_INS_VCVTSS2SI,
	X86_INS_VCVTSS2USI,
	X86_INS_VCVTTPD2DQX,
	X86_INS_VCVTTPD2DQ,
	X86_INS_VCVTTPD2UDQ,
	X86_INS_VCVTTPS2DQ,
	X86_INS_VCVTTPS2UDQ,
	X86_INS_VCVTUDQ2PD,
	X86_INS_VCVTUDQ2PS,
	X86_INS_VDIVPD,
	X86_INS_VDIVPS,
	X86_INS_VDIVSD,
	X86_INS_VDIVSS,
	X86_INS_VDPPD,
	X86_INS_VDPPS,
	X86_INS_VERR,
	X86_INS_VERW,
	X86_INS_VEXTRACTF128,
	X86_INS_VEXTRACTF32X4,
	X86_INS_VEXTRACTF64X4,
	X86_INS_VEXTRACTI128,
	X86_INS_VEXTRACTI32X4,
	X86_INS_VEXTRACTI64X4,
	X86_INS_VEXTRACTPS,
	X86_INS_VFMADD132PD,
	X86_INS_VFMADD132PS,
	X86_INS_VFMADD213PD,
	X86_INS_VFMADD213PS,
	X86_INS_VFMADDPD,
	X86_INS_VFMADD231PD,
	X86_INS_VFMADDPS,
	X86_INS_VFMADD231PS,
	X86_INS_VFMADDSD,
	X86_INS_VFMADD213SD,
	X86_INS_VFMADD132SD,
	X86_INS_VFMADD231SD,
	X86_INS_VFMADDSS,
	X86_INS_VFMADD213SS,
	X86_INS_VFMADD132SS,
	X86_INS_VFMADD231SS,
	X86_INS_VFMADDSUB132PD,
	X86_INS_VFMADDSUB132PS,
	X86_INS_VFMADDSUB213PD,
	X86_INS_VFMADDSUB213PS,
	X86_INS_VFMADDSUBPD,
	X86_INS_VFMADDSUB231PD,
	X86_INS_VFMADDSUBPS,
	X86_INS_VFMADDSUB231PS,
	X86_INS_VFMSUB132PD,
	X86_INS_VFMSUB132PS,
	X86_INS_VFMSUB213PD,
	X86_INS_VFMSUB213PS,
	X86_INS_VFMSUBADD132PD,
	X86_INS_VFMSUBADD132PS,
	X86_INS_VFMSUBADD213PD,
	X86_INS_VFMSUBADD213PS,
	X86_INS_VFMSUBADDPD,
	X86_INS_VFMSUBADD231PD,
	X86_INS_VFMSUBADDPS,
	X86_INS_VFMSUBADD231PS,
	X86_INS_VFMSUBPD,
	X86_INS_VFMSUB231PD,
	X86_INS_VFMSUBPS,
	X86_INS_VFMSUB231PS,
	X86_INS_VFMSUBSD,
	X86_INS_VFMSUB213SD,
	X86_INS_VFMSUB132SD,
	X86_INS_VFMSUB231SD,
	X86_INS_VFMSUBSS,
	X86_INS_VFMSUB213SS,
	X86_INS_VFMSUB132SS,
	X86_INS_VFMSUB231SS,
	X86_INS_VFNMADD132PD,
	X86_INS_VFNMADD132PS,
	X86_INS_VFNMADD213PD,
	X86_INS_VFNMADD213PS,
	X86_INS_VFNMADDPD,
	X86_INS_VFNMADD231PD,
	X86_INS_VFNMADDPS,
	X86_INS_VFNMADD231PS,
	X86_INS_VFNMADDSD,
	X86_INS_VFNMADD213SD,
	X86_INS_VFNMADD132SD,
	X86_INS_VFNMADD231SD,
	X86_INS_VFNMADDSS,
	X86_INS_VFNMADD213SS,
	X86_INS_VFNMADD132SS,
	X86_INS_VFNMADD231SS,
	X86_INS_VFNMSUB132PD,
	X86_INS_VFNMSUB132PS,
	X86_INS_VFNMSUB213PD,
	X86_INS_VFNMSUB213PS,
	X86_INS_VFNMSUBPD,
	X86_INS_VFNMSUB231PD,
	X86_INS_VFNMSUBPS,
	X86_INS_VFNMSUB231PS,
	X86_INS_VFNMSUBSD,
	X86_INS_VFNMSUB213SD,
	X86_INS_VFNMSUB132SD,
	X86_INS_VFNMSUB231SD,
	X86_INS_VFNMSUBSS,
	X86_INS_VFNMSUB213SS,
	X86_INS_VFNMSUB132SS,
	X86_INS_VFNMSUB231SS,
	X86_INS_VFRCZPD,
	X86_INS_VFRCZPS,
	X86_INS_VFRCZSD,
	X86_INS_VFRCZSS,
	X86_INS_VORPD,
	X86_INS_VORPS,
	X86_INS_VXORPD,
	X86_INS_VXORPS,
	X86_INS_VGATHERDPD,
	X86_INS_VGATHERDPS,
	X86_INS_VGATHERPF0DPD,
	X86_INS_VGATHERPF0DPS,
	X86_INS_VGATHERPF0QPD,
	X86_INS_VGATHERPF0QPS,
	X86_INS_VGATHERPF1DPD,
	X86_INS_VGATHERPF1DPS,
	X86_INS_VGATHERPF1QPD,
	X86_INS_VGATHERPF1QPS,
	X86_INS_VGATHERQPD,
	X86_INS_VGATHERQPS,
	X86_INS_VHADDPD,
	X86_INS_VHADDPS,
	X86_INS_VHSUBPD,
	X86_INS_VHSUBPS,
	X86_INS_VINSERTF128,
	X86_INS_VINSERTF32X4,
	X86_INS_VINSERTF64X4,
	X86_INS_VINSERTI128,
	X86_INS_VINSERTI32X4,
	X86_INS_VINSERTI64X4,
	X86_INS_VINSERTPS,
	X86_INS_VLDDQU,
	X86_INS_VLDMXCSR,
	X86_INS_VMASKMOVDQU,
	X86_INS_VMASKMOVPD,
	X86_INS_VMASKMOVPS,
	X86_INS_VMAXPD,
	X86_INS_VMAXPS,
	X86_INS_VMAXSD,
	X86_INS_VMAXSS,
	X86_INS_VMCALL,
	X86_INS_VMCLEAR,
	X86_INS_VMFUNC,
	X86_INS_VMINPD,
	X86_INS_VMINPS,
	X86_INS_VMINSD,
	X86_INS_VMINSS,
	X86_INS_VMLAUNCH,
	X86_INS_VMLOAD,
	X86_INS_VMMCALL,
	X86_INS_VMOVQ,
	X86_INS_VMOVDDUP,
	X86_INS_VMOVD,
	X86_INS_VMOVDQA32,
	X86_INS_VMOVDQA64,
	X86_INS_VMOVDQA,
	X86_INS_VMOVDQU16,
	X86_INS_VMOVDQU32,
	X86_INS_VMOVDQU64,
	X86_INS_VMOVDQU8,
	X86_INS_VMOVDQU,
	X86_INS_VMOVHLPS,
	X86_INS_VMOVHPD,
	X86_INS_VMOVHPS,
	X86_INS_VMOVLHPS,
	X86_INS_VMOVLPD,
	X86_INS_VMOVLPS,
	X86_INS_VMOVMSKPD,
	X86_INS_VMOVMSKPS,
	X86_INS_VMOVNTDQA,
	X86_INS_VMOVNTDQ,
	X86_INS_VMOVNTPD,
	X86_INS_VMOVNTPS,
	X86_INS_VMOVSD,
	X86_INS_VMOVSHDUP,
	X86_INS_VMOVSLDUP,
	X86_INS_VMOVSS,
	X86_INS_VMOVUPD,
	X86_INS_VMOVUPS,
	X86_INS_VMPSADBW,
	X86_INS_VMPTRLD,
	X86_INS_VMPTRST,
	X86_INS_VMREAD,
	X86_INS_VMRESUME,
	X86_INS_VMRUN,
	X86_INS_VMSAVE,
	X86_INS_VMULPD,
	X86_INS_VMULPS,
	X86_INS_VMULSD,
	X86_INS_VMULSS,
	X86_INS_VMWRITE,
	X86_INS_VMXOFF,
	X86_INS_VMXON,
	X86_INS_VPABSB,
	X86_INS_VPABSD,
	X86_INS_VPABSQ,
	X86_INS_VPABSW,
	X86_INS_VPACKSSDW,
	X86_INS_VPACKSSWB,
	X86_INS_VPACKUSDW,
	X86_INS_VPACKUSWB,
	X86_INS_VPADDB,
	X86_INS_VPADDD,
	X86_INS_VPADDQ,
	X86_INS_VPADDSB,
	X86_INS_VPADDSW,
	X86_INS_VPADDUSB,
	X86_INS_VPADDUSW,
	X86_INS_VPADDW,
	X86_INS_VPALIGNR,
	X86_INS_VPANDD,
	X86_INS_VPANDND,
	X86_INS_VPANDNQ,
	X86_INS_VPANDN,
	X86_INS_VPANDQ,
	X86_INS_VPAND,
	X86_INS_VPAVGB,
	X86_INS_VPAVGW,
	X86_INS_VPBLENDD,
	X86_INS_VPBLENDMD,
	X86_INS_VPBLENDMQ,
	X86_INS_VPBLENDVB,
	X86_INS_VPBLENDW,
	X86_INS_VPBROADCASTB,
	X86_INS_VPBROADCASTD,
	X86_INS_VPBROADCASTMB2Q,
	X86_INS_VPBROADCASTMW2D,
	X86_INS_VPBROADCASTQ,
	X86_INS_VPBROADCASTW,
	X86_INS_VPCLMULQDQ,
	X86_INS_VPCMOV,
	X86_INS_VPCMP,
	X86_INS_VPCMPD,
	X86_INS_VPCMPEQB,
	X86_INS_VPCMPEQD,
	X86_INS_VPCMPEQQ,
	X86_INS_VPCMPEQW,
	X86_INS_VPCMPESTRI,
	X86_INS_VPCMPESTRM,
	X86_INS_VPCMPGTB,
	X86_INS_VPCMPGTD,
	X86_INS_VPCMPGTQ,
	X86_INS_VPCMPGTW,
	X86_INS_VPCMPISTRI,
	X86_INS_VPCMPISTRM,
	X86_INS_VPCMPQ,
	X86_INS_VPCMPUD,
	X86_INS_VPCMPUQ,
	X86_INS_VPCOMB,
	X86_INS_VPCOMD,
	X86_INS_VPCOMQ,
	X86_INS_VPCOMUB,
	X86_INS_VPCOMUD,
	X86_INS_VPCOMUQ,
	X86_INS_VPCOMUW,
	X86_INS_VPCOMW,
	X86_INS_VPCONFLICTD,
	X86_INS_VPCONFLICTQ,
	X86_INS_VPERM2F128,
	X86_INS_VPERM2I128,
	X86_INS_VPERMD,
	X86_INS_VPERMI2D,
	X86_INS_VPERMI2PD,
	X86_INS_VPERMI2PS,
	X86_INS_VPERMI2Q,
	X86_INS_VPERMIL2PD,
	X86_INS_VPERMIL2PS,
	X86_INS_VPERMILPD,
	X86_INS_VPERMILPS,
	X86_INS_VPERMPD,
	X86_INS_VPERMPS,
	X86_INS_VPERMQ,
	X86_INS_VPERMT2D,
	X86_INS_VPERMT2PD,
	X86_INS_VPERMT2PS,
	X86_INS_VPERMT2Q,
	X86_INS_VPEXTRB,
	X86_INS_VPEXTRD,
	X86_INS_VPEXTRQ,
	X86_INS_VPEXTRW,
	X86_INS_VPGATHERDD,
	X86_INS_VPGATHERDQ,
	X86_INS_VPGATHERQD,
	X86_INS_VPGATHERQQ,
	X86_INS_VPHADDBD,
	X86_INS_VPHADDBQ,
	X86_INS_VPHADDBW,
	X86_INS_VPHADDDQ,
	X86_INS_VPHADDD,
	X86_INS_VPHADDSW,
	X86_INS_VPHADDUBD,
	X86_INS_VPHADDUBQ,
	X86_INS_VPHADDUBW,
	X86_INS_VPHADDUDQ,
	X86_INS_VPHADDUWD,
	X86_INS_VPHADDUWQ,
	X86_INS_VPHADDWD,
	X86_INS_VPHADDWQ,
	X86_INS_VPHADDW,
	X86_INS_VPHMINPOSUW,
	X86_INS_VPHSUBBW,
	X86_INS_VPHSUBDQ,
	X86_INS_VPHSUBD,
	X86_INS_VPHSUBSW,
	X86_INS_VPHSUBWD,
	X86_INS_VPHSUBW,
	X86_INS_VPINSRB,
	X86_INS_VPINSRD,
	X86_INS_VPINSRQ,
	X86_INS_VPINSRW,
	X86_INS_VPLZCNTD,
	X86_INS_VPLZCNTQ,
	X86_INS_VPMACSDD,
	X86_INS_VPMACSDQH,
	X86_INS_VPMACSDQL,
	X86_INS_VPMACSSDD,
	X86_INS_VPMACSSDQH,
	X86_INS_VPMACSSDQL,
	X86_INS_VPMACSSWD,
	X86_INS_VPMACSSWW,
	X86_INS_VPMACSWD,
	X86_INS_VPMACSWW,
	X86_INS_VPMADCSSWD,
	X86_INS_VPMADCSWD,
	X86_INS_VPMADDUBSW,
	X86_INS_VPMADDWD,
	X86_INS_VPMASKMOVD,
	X86_INS_VPMASKMOVQ,
	X86_INS_VPMAXSB,
	X86_INS_VPMAXSD,
	X86_INS_VPMAXSQ,
	X86_INS_VPMAXSW,
	X86_INS_VPMAXUB,
	X86_INS_VPMAXUD,
	X86_INS_VPMAXUQ,
	X86_INS_VPMAXUW,
	X86_INS_VPMINSB,
	X86_INS_VPMINSD,
	X86_INS_VPMINSQ,
	X86_INS_VPMINSW,
	X86_INS_VPMINUB,
	X86_INS_VPMINUD,
	X86_INS_VPMINUQ,
	X86_INS_VPMINUW,
	X86_INS_VPMOVDB,
	X86_INS_VPMOVDW,
	X86_INS_VPMOVMSKB,
	X86_INS_VPMOVQB,
	X86_INS_VPMOVQD,
	X86_INS_VPMOVQW,
	X86_INS_VPMOVSDB,
	X86_INS_VPMOVSDW,
	X86_INS_VPMOVSQB,
	X86_INS_VPMOVSQD,
	X86_INS_VPMOVSQW,
	X86_INS_VPMOVSXBD,
	X86_INS_VPMOVSXBQ,
	X86_INS_VPMOVSXBW,
	X86_INS_VPMOVSXDQ,
	X86_INS_VPMOVSXWD,
	X86_INS_VPMOVSXWQ,
	X86_INS_VPMOVUSDB,
	X86_INS_VPMOVUSDW,
	X86_INS_VPMOVUSQB,
	X86_INS_VPMOVUSQD,
	X86_INS_VPMOVUSQW,
	X86_INS_VPMOVZXBD,
	X86_INS_VPMOVZXBQ,
	X86_INS_VPMOVZXBW,
	X86_INS_VPMOVZXDQ,
	X86_INS_VPMOVZXWD,
	X86_INS_VPMOVZXWQ,
	X86_INS_VPMULDQ,
	X86_INS_VPMULHRSW,
	X86_INS_VPMULHUW,
	X86_INS_VPMULHW,
	X86_INS_VPMULLD,
	X86_INS_VPMULLW,
	X86_INS_VPMULUDQ,
	X86_INS_VPORD,
	X86_INS_VPORQ,
	X86_INS_VPOR,
	X86_INS_VPPERM,
	X86_INS_VPROTB,
	X86_INS_VPROTD,
	X86_INS_VPROTQ,
	X86_INS_VPROTW,
	X86_INS_VPSADBW,
	X86_INS_VPSCATTERDD,
	X86_INS_VPSCATTERDQ,
	X86_INS_VPSCATTERQD,
	X86_INS_VPSCATTERQQ,
	X86_INS_VPSHAB,
	X86_INS_VPSHAD,
	X86_INS_VPSHAQ,
	X86_INS_VPSHAW,
	X86_INS_VPSHLB,
	X86_INS_VPSHLD,
	X86_INS_VPSHLQ,
	X86_INS_VPSHLW,
	X86_INS_VPSHUFB,
	X86_INS_VPSHUFD,
	X86_INS_VPSHUFHW,
	X86_INS_VPSHUFLW,
	X86_INS_VPSIGNB,
	X86_INS_VPSIGND,
	X86_INS_VPSIGNW,
	X86_INS_VPSLLDQ,
	X86_INS_VPSLLD,
	X86_INS_VPSLLQ,
	X86_INS_VPSLLVD,
	X86_INS_VPSLLVQ,
	X86_INS_VPSLLW,
	X86_INS_VPSRAD,
	X86_INS_VPSRAQ,
	X86_INS_VPSRAVD,
	X86_INS_VPSRAVQ,
	X86_INS_VPSRAW,
	X86_INS_VPSRLDQ,
	X86_INS_VPSRLD,
	X86_INS_VPSRLQ,
	X86_INS_VPSRLVD,
	X86_INS_VPSRLVQ,
	X86_INS_VPSRLW,
	X86_INS_VPSUBB,
	X86_INS_VPSUBD,
	X86_INS_VPSUBQ,
	X86_INS_VPSUBSB,
	X86_INS_VPSUBSW,
	X86_INS_VPSUBUSB,
	X86_INS_VPSUBUSW,
	X86_INS_VPSUBW,
	X86_INS_VPTESTMD,
	X86_INS_VPTESTMQ,
	X86_INS_VPTESTNMD,
	X86_INS_VPTESTNMQ,
	X86_INS_VPTEST,
	X86_INS_VPUNPCKHBW,
	X86_INS_VPUNPCKHDQ,
	X86_INS_VPUNPCKHQDQ,
	X86_INS_VPUNPCKHWD,
	X86_INS_VPUNPCKLBW,
	X86_INS_VPUNPCKLDQ,
	X86_INS_VPUNPCKLQDQ,
	X86_INS_VPUNPCKLWD,
	X86_INS_VPXORD,
	X86_INS_VPXORQ,
	X86_INS_VPXOR,
	X86_INS_VRCP14PD,
	X86_INS_VRCP14PS,
	X86_INS_VRCP14SD,
	X86_INS_VRCP14SS,
	X86_INS_VRCP28PD,
	X86_INS_VRCP28PS,
	X86_INS_VRCP28SD,
	X86_INS_VRCP28SS,
	X86_INS_VRCPPS,
	X86_INS_VRCPSS,
	X86_INS_VRNDSCALEPD,
	X86_INS_VRNDSCALEPS,
	X86_INS_VRNDSCALESD,
	X86_INS_VRNDSCALESS,
	X86_INS_VROUNDPD,
	X86_INS_VROUNDPS,
	X86_INS_VROUNDSD,
	X86_INS_VROUNDSS,
	X86_INS_VRSQRT14PD,
	X86_INS_VRSQRT14PS,
	X86_INS_VRSQRT14SD,
	X86_INS_VRSQRT14SS,
	X86_INS_VRSQRT28PD,
	X86_INS_VRSQRT28PS,
	X86_INS_VRSQRT28SD,
	X86_INS_VRSQRT28SS,
	X86_INS_VRSQRTPS,
	X86_INS_VRSQRTSS,
	X86_INS_VSCATTERDPD,
	X86_INS_VSCATTERDPS,
	X86_INS_VSCATTERPF0DPD,
	X86_INS_VSCATTERPF0DPS,
	X86_INS_VSCATTERPF0QPD,
	X86_INS_VSCATTERPF0QPS,
	X86_INS_VSCATTERPF1DPD,
	X86_INS_VSCATTERPF1DPS,
	X86_INS_VSCATTERPF1QPD,
	X86_INS_VSCATTERPF1QPS,
	X86_INS_VSCATTERQPD,
	X86_INS_VSCATTERQPS,
	X86_INS_VSHUFPD,
	X86_INS_VSHUFPS,
	X86_INS_VSQRTPD,
	X86_INS_VSQRTPS,
	X86_INS_VSQRTSD,
	X86_INS_VSQRTSS,
	X86_INS_VSTMXCSR,
	X86_INS_VSUBPD,
	X86_INS_VSUBPS,
	X86_INS_VSUBSD,
	X86_INS_VSUBSS,
	X86_INS_VTESTPD,
	X86_INS_VTESTPS,
	X86_INS_VUNPCKHPD,
	X86_INS_VUNPCKHPS,
	X86_INS_VUNPCKLPD,
	X86_INS_VUNPCKLPS,
	X86_INS_VZEROALL,
	X86_INS_VZEROUPPER,
	X86_INS_WAIT,
	X86_INS_WBINVD,
	X86_INS_WRFSBASE,
	X86_INS_WRGSBASE,
	X86_INS_WRMSR,
	X86_INS_XABORT,
	X86_INS_XACQUIRE,
	X86_INS_XBEGIN,
	X86_INS_XCHG,
	X86_INS_FXCH,
	X86_INS_XCRYPTCBC,
	X86_INS_XCRYPTCFB,
	X86_INS_XCRYPTCTR,
	X86_INS_XCRYPTECB,
	X86_INS_XCRYPTOFB,
	X86_INS_XEND,
	X86_INS_XGETBV,
	X86_INS_XLATB,
	X86_INS_XRELEASE,
	X86_INS_XRSTOR,
	X86_INS_XRSTOR64,
	X86_INS_XSAVE,
	X86_INS_XSAVE64,
	X86_INS_XSAVEOPT,
	X86_INS_XSAVEOPT64,
	X86_INS_XSETBV,
	X86_INS_XSHA1,
	X86_INS_XSHA256,
	X86_INS_XSTORE,
	X86_INS_XTEST,

	X86_INS_ENDING,	// mark the end of the list of insn
} x86_insn;

//> Group of X86 instructions
typedef enum  x86_insn_group {
	X86_GRP_INVALID = 0, // = CS_GRP_INVALID

	//> Generic groups
	// all jump instructions (conditional+direct+indirect jumps)
	X86_GRP_JUMP,	// = CS_GRP_JUMP
	// all call instructions
	X86_GRP_CALL,	// = CS_GRP_CALL
	// all return instructions
	X86_GRP_RET,	// = CS_GRP_RET
	// all interrupt instructions (int+syscall)
	X86_GRP_INT,	// = CS_GRP_INT
	// all interrupt return instructions
	X86_GRP_IRET,	// = CS_GRP_IRET

	//> Architecture-specific groups
	X86_GRP_VM = 128,	// all virtualization instructions (VT-x + AMD-V)
	X86_GRP_3DNOW,
	X86_GRP_AES,
	X86_GRP_ADX,
	X86_GRP_AVX,
	X86_GRP_AVX2,
	X86_GRP_AVX512,
	X86_GRP_BMI,
	X86_GRP_BMI2,
	X86_GRP_CMOV,
	X86_GRP_F16C,
	X86_GRP_FMA,
	X86_GRP_FMA4,
	X86_GRP_FSGSBASE,
	X86_GRP_HLE,
	X86_GRP_MMX,
	X86_GRP_MODE32,
	X86_GRP_MODE64,
	X86_GRP_RTM,
	X86_GRP_SHA,
	X86_GRP_SSE1,
	X86_GRP_SSE2,
	X86_GRP_SSE3,
	X86_GRP_SSE41,
	X86_GRP_SSE42,
	X86_GRP_SSE4A,
	X86_GRP_SSSE3,
	X86_GRP_PCLMUL,
	X86_GRP_XOP,
	X86_GRP_CDI,
	X86_GRP_ERI,
	X86_GRP_TBM,
	X86_GRP_16BITMODE,
	X86_GRP_NOT64BITMODE,
	X86_GRP_SGX,
	X86_GRP_DQI,
	X86_GRP_BWI,
	X86_GRP_PFI,
	X86_GRP_VLX,
	X86_GRP_SMAP,
	X86_GRP_NOVLX,

	X86_GRP_ENDING
} x86_insn_group;
]]

