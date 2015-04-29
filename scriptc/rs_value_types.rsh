/*
 * Copyright (C) 2015 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Don't edit this file!  It is auto-generated by frameworks/rs/api/generate.sh.

/*
 * rs_value_types.rsh: Numerical Types
 *
 * Scalars:
 *
 * RenderScript supports the following scalar numerical types:
 *
 *                    8 bits           16 bits            32 bits          64 bits
 * Integer:           char, int8_t     short, int16_t     int32_t          long, long long, int64_t
 * Unsigned integer:  uchar, uint8_t   ushort, uint16_t   uint, uint32_t   ulong, uint64_t
 * Floating point:                                        float            double
 *
 *
 * Vectors:
 *
 * RenderScript supports fixed size vectors of length 2, 3, and 4.
 * Vectors are declared using the common type name followed by a 2, 3, or 4.
 * E.g. float4, int3, double2, ulong4.
 *
 * To create vector literals, use the vector type followed by the values enclosed
 * between parentheses, e.g. (float3)(1.0f, 2.0f, 3.0f).
 *
 * Entries of a vector can be accessed using different naming styles.
 *
 * Single entries can be accessed by following the variable name with a dot and:
 * - The letters x, y, z, and w,
 * - The letters r, g, b, and a,
 * - The letter s or S, followed by a zero based index.
 *
 * For example, with int4 myVar; the following are equivalent:
 *   myVar.x == myVar.r == myVar.s0 == myVar.S0
 *   myVar.y == myVar.g == myVar.s1 == myVar.S1
 *   myVar.z == myVar.b == myVar.s2 == myVar.S2
 *   myVar.w == myVar.a == myVar.s3 == myVar.S3
 *
 * Multiple entries of a vector can be accessed at once by using an identifier that is
 * the concatenation of multiple letters or indices.  The resulting vector has a size
 * equal to the number of entries named.
 *
 * With the example above, the middle two entries can be accessed using
 * myVar.yz, myVar.gb, myVar.s12, and myVar.S12.
 *
 * The entries don't have to be contiguous or in increasing order.  Entries can even be
 * repeated, as long as we're not trying to assign to it.  You also can't mix the naming
 * styles.
 *
 * Here are examples of what can or can't be done:
 * float4 v4;
 * float3 v3;
 * float2 v2;
 * v2 = v4.xx; // Valid
 * v3 = v4.zxw; // Valid
 * v3 = v4.bba; // Valid
 * v3 = v4.s032; // Valid
 * v3.s120 = v4.S233; // Valid
 * v4.yz = v3.rg; // Valid
 * v4.yzx = v3.rg; // Invalid: mismatched sizes
 * v4.yzz = v3; // Invalid: z appears twice in an assignment
 * v3 = v3.xas0; // Invalid: can't mix xyzw with rgba nor s0...
 * v3 = v4.s034; // Invalid: the digit can only be 0, 1, 2, or 3
 *
 *
 * Matrices and Quaternions:
 *
 * RenderScript supports fixed size square matrices of floats of size 2x2, 3x3, and 4x4.
 * The types are named rs_matrix2x2, rs_matrix3x3, and rs_matrix4x4.  See
 * Matrix Functions for the list of operations.
 *
 * Quaternions are also supported via rs_quaternion.  See Quaterion Functions for the list
 * of operations.
 */

#ifndef RENDERSCRIPT_RS_VALUE_TYPES_RSH
#define RENDERSCRIPT_RS_VALUE_TYPES_RSH

/*
 * int8_t: 8 bit signed integer
 *
 * 8 bit signed integer type.
 */
typedef char int8_t;

/*
 * int16_t: 16 bit signed integer
 *
 * A 16 bit signed integer type.
 */
typedef short int16_t;

/*
 * int32_t: 32 bit signed integer
 *
 * A 32 bit signed integer type.
 */
typedef int int32_t;

/*
 * int64_t: 64 bit signed integer
 *
 * A 64 bit signed integer type.
 */
#if !defined(RS_VERSION) || (RS_VERSION <= 20)
typedef long long int64_t;
#endif

#if (defined(RS_VERSION) && (RS_VERSION >= 21))
typedef long int64_t;
#endif

/*
 * uint8_t: 8 bit unsigned integer
 *
 * 8 bit unsigned integer type.
 */
typedef unsigned char uint8_t;

/*
 * uint16_t: 16 bit unsigned integer
 *
 * A 16 bit unsigned integer type.
 */
typedef unsigned short uint16_t;

/*
 * uint32_t: 32 bit unsigned integer
 *
 * A 32 bit unsigned integer type.
 */
typedef unsigned int uint32_t;

/*
 * uint64_t: 64 bit unsigned integer
 *
 * A 64 bit unsigned integer type.
 */
#if !defined(RS_VERSION) || (RS_VERSION <= 20)
typedef unsigned long long uint64_t;
#endif

#if (defined(RS_VERSION) && (RS_VERSION >= 21))
typedef unsigned long uint64_t;
#endif

/*
 * uchar: 8 bit unsigned integer
 *
 * 8 bit unsigned integer type.
 */
typedef uint8_t uchar;

/*
 * ushort: 16 bit unsigned integer
 *
 * A 16 bit unsigned integer type.
 */
typedef uint16_t ushort;

/*
 * uint: 32 bit unsigned integer
 *
 * A 32 bit unsigned integer type.
 */
typedef uint32_t uint;

/*
 * ulong: 64 bit unsigned integer
 *
 * A 64 bit unsigned integer type.
 */
typedef uint64_t ulong;

/*
 * size_t: Unsigned size type
 *
 * Unsigned size type.  The number of bits depend on the compilation flags.
 */
#ifdef __LP64__
typedef uint64_t size_t;
#endif

#ifndef __LP64__
typedef uint32_t size_t;
#endif

/*
 * ssize_t: Signed size type
 *
 * Signed size type.  The number of bits depend on the compilation flags.
 */
#ifdef __LP64__
typedef int64_t ssize_t;
#endif

#ifndef __LP64__
typedef int32_t ssize_t;
#endif

/*
 * float2: Two 32 bit floats
 *
 * A vector of two floats.  These two floats are packed into a single 64 bit field
 * with a 64 bit alignment.
 *
 * A vector of two floats.  These two floats are packed into a single 64 bit field
 * with a 64 bit alignment.
 */
typedef float __attribute__((ext_vector_type(2))) float2;

/*
 * float3: Three 32 bit floats
 *
 * A vector of three floats.  These three floats are packed into a single 128 bit field
 * with a 128 bit alignment.
 */
typedef float __attribute__((ext_vector_type(3))) float3;

/*
 * float4: Four 32 bit floats
 *
 * A vector of four floats type.  These four floats are packed into a single 128 bit field
 * with a 128 bit alignment.
 */
typedef float __attribute__((ext_vector_type(4))) float4;

/*
 * double2: Two 64 bit floats
 *
 * A vector of two doubles.  These two double fields packed into a single 128 bit field
 * with a 128 bit alignment.
 */
typedef double __attribute__((ext_vector_type(2))) double2;

/*
 * double3: Three 64 bit floats
 *
 * A vector of three doubles.  These three double fields packed into a single 256 bit field
 * with a 256 bit alignment.
 */
typedef double __attribute__((ext_vector_type(3))) double3;

/*
 * double4: Four 64 bit floats
 *
 * A vector of four doubles.  These four double fields packed into a single 256 bit field
 * with a 256 bit alignment.
 */
typedef double __attribute__((ext_vector_type(4))) double4;

/*
 * uchar2: Two 8 bit unsigned integers
 *
 * A vector of two uchars.  These two uchar fields packed into a single 16 bit field
 * with a 16 bit alignment.
 */
typedef uchar __attribute__((ext_vector_type(2))) uchar2;

/*
 * uchar3: Three 8 bit unsigned integers
 *
 * A vector of three uchars.  These three uchar fields packed into a single 32 bit field
 * with a 32 bit alignment.
 */
typedef uchar __attribute__((ext_vector_type(3))) uchar3;

/*
 * uchar4: Four 8 bit unsigned integers
 *
 * A vector of four uchars.  These four uchar fields packed into a single 32 bit field
 * with a 32 bit alignment.
 */
typedef uchar __attribute__((ext_vector_type(4))) uchar4;

/*
 * ushort2: Two 16 bit unsigned integers
 *
 * A vector of two ushorts.  These two ushort fields packed into a single 32 bit field
 * with a 32 bit alignment.
 */
typedef ushort __attribute__((ext_vector_type(2))) ushort2;

/*
 * ushort3: Three 16 bit unsigned integers
 *
 * A vector of three ushorts.  These three ushort fields packed into a single 64 bit field
 * with a 64 bit alignment.
 */
typedef ushort __attribute__((ext_vector_type(3))) ushort3;

/*
 * ushort4: Four 16 bit unsigned integers
 *
 * A vector of four ushorts.  These four ushort fields packed into a single 64 bit field
 * with a 64 bit alignment.
 */
typedef ushort __attribute__((ext_vector_type(4))) ushort4;

/*
 * uint2: Two 32 bit unsigned integers
 *
 * A vector of two uints.  These two uints are packed into a single 64 bit field
 * with a 64 bit alignment.
 */
typedef uint __attribute__((ext_vector_type(2))) uint2;

/*
 * uint3: Three 32 bit unsigned integers
 *
 * A vector of three uints.  These three uints are packed into a single 128 bit field
 * with a 128 bit alignment.
 */
typedef uint __attribute__((ext_vector_type(3))) uint3;

/*
 * uint4: Four 32 bit unsigned integers
 *
 * A vector of four uints.  These four uints are packed into a single 128 bit field
 * with a 128 bit alignment.
 */
typedef uint __attribute__((ext_vector_type(4))) uint4;

/*
 * ulong2: Two 64 bit unsigned integers
 *
 * A vector of two ulongs.  These two ulongs are packed into a single 128 bit field
 * with a 128 bit alignment.
 */
typedef ulong __attribute__((ext_vector_type(2))) ulong2;

/*
 * ulong3: Three 64 bit unsigned integers
 *
 * A vector of three ulongs.  These three ulong fields packed into a single 256 bit field
 * with a 256 bit alignment.
 */
typedef ulong __attribute__((ext_vector_type(3))) ulong3;

/*
 * ulong4: Four 64 bit unsigned integers
 *
 * A vector of four ulongs.  These four ulong fields packed into a single 256 bit field
 * with a 256 bit alignment.
 */
typedef ulong __attribute__((ext_vector_type(4))) ulong4;

/*
 * char2: Two 8 bit signed integers
 *
 * A vector of two chars.  These two chars are packed into a single 16 bit field
 * with a 16 bit alignment.
 */
typedef char __attribute__((ext_vector_type(2))) char2;

/*
 * char3: Three 8 bit signed integers
 *
 * A vector of three chars.  These three chars are packed into a single 32 bit field
 * with a 32 bit alignment.
 */
typedef char __attribute__((ext_vector_type(3))) char3;

/*
 * char4: Four 8 bit signed integers
 *
 * A vector of four chars.  These four chars are packed into a single 32 bit field
 * with a 32 bit alignment.
 */
typedef char __attribute__((ext_vector_type(4))) char4;

/*
 * short2: Two 16 bit signed integers
 *
 * A vector of two shorts.  These two shorts are packed into a single 32 bit field
 * with a 32 bit alignment.
 */
typedef short __attribute__((ext_vector_type(2))) short2;

/*
 * short3: Three 16 bit signed integers
 *
 * A vector of three shorts.  These three short fields packed into a single 64 bit field
 * with a 64 bit alignment.
 */
typedef short __attribute__((ext_vector_type(3))) short3;

/*
 * short4: Four 16 bit signed integers
 *
 * A vector of four shorts.  These four short fields packed into a single 64 bit field
 * with a 64 bit alignment.
 */
typedef short __attribute__((ext_vector_type(4))) short4;

/*
 * int2: Two 32 bit signed integers
 *
 * A vector of two ints.  These two ints are packed into a single 64 bit field
 * with a 64 bit alignment.
 */
typedef int __attribute__((ext_vector_type(2))) int2;

/*
 * int3: Three 32 bit signed integers
 *
 * A vector of three ints.  These three ints are packed into a single 128 bit field
 * with a 128 bit alignment.
 */
typedef int __attribute__((ext_vector_type(3))) int3;

/*
 * int4: Four 32 bit signed integers
 *
 * A vector of four ints.  These two fours are packed into a single 128 bit field
 * with a 128 bit alignment.
 */
typedef int __attribute__((ext_vector_type(4))) int4;

/*
 * long2: Two 64 bit signed integers
 *
 * A vector of two longs.  These two longs are packed into a single 128 bit field
 * with a 128 bit alignment.
 */
typedef long __attribute__((ext_vector_type(2))) long2;

/*
 * long3: Three 64 bit signed integers
 *
 * A vector of three longs.  These three longs are packed into a single 256 bit field
 * with a 256 bit alignment.
 */
typedef long __attribute__((ext_vector_type(3))) long3;

/*
 * long4: Four 64 bit signed integers
 *
 * A vector of four longs.  These four longs are packed into a single 256 bit field
 * with a 256 bit alignment.
 */
typedef long __attribute__((ext_vector_type(4))) long4;

/*
 * rs_matrix2x2: 2x2 matrix of 32 bit floats
 *
 * A square 2x2 matrix of floats.  The entries are stored in the array at the
 * location [row*2 + col].
 *
 * See Matrix Functions.
 */
typedef struct {
    float m[4];
} rs_matrix2x2;

/*
 * rs_matrix3x3: 3x3 matrix of 32 bit floats
 *
 * A square 3x3 matrix of floats.  The entries are stored in the array at the
 * location [row*3 + col].
 *
 * See Matrix Functions.
 */
typedef struct {
    float m[9];
} rs_matrix3x3;

/*
 * rs_matrix4x4: 4x4 matrix of 32 bit floats
 *
 * A square 4x4 matrix of floats.  The entries are stored in the array at the
 * location [row*4 + col].
 *
 * See Matrix Functions.
 */
typedef struct {
    float m[16];
} rs_matrix4x4;

/*
 * rs_quaternion: Quaternion
 *
 * A square 4x4 matrix of floats that represents a quaternion.
 *
 * See Quaternion Functions.
 */
typedef float4 rs_quaternion;

#endif // RENDERSCRIPT_RS_VALUE_TYPES_RSH
