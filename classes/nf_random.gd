class_name NfRandom
## A class for random.
##
## Version: 1.0.0
## [codeblock]
## var s = NfRandom.generate_string(32, NfRandom.ALPHABET_CHARS)
## var p = NfRandom.generate_password(16)
## [/codeblock]
##
## @tutorial: https://github.com/nekofleet/nf-class-collection


#-------------------------------------------------------------------------------
# Constants
#-------------------------------------------------------------------------------
## Printable characters and space.
const PRINTABLE_CHARS = " !\"#$%&'()*+,-./0123456789:;<=>?@"\
	+ "ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`"\
	+ "abcdefghijklmnopqrstuvwxyz{|}~"

## Numeric characters.
const NUMERIC_CHARS = "0123456789"

## Uppercase alphabet characters.
const UPPERCASE_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

## Lowercase alphabet characters.
const LOWERCASE_CHARS = "abcdefghijklmnopqrstuvwxyz"

## Alphabet characters.
const ALPHABET_CHARS = UPPERCASE_CHARS + LOWERCASE_CHARS

## Password characters.
const PASSWORD_CHARS = NUMERIC_CHARS + UPPERCASE_CHARS + LOWERCASE_CHARS


#-------------------------------------------------------------------------------
# Static functions
#-------------------------------------------------------------------------------
## Returns a random generated string.[br]
## [b]Unicode not supported.[/b]
static func generate_string(length: int, chars: String = PRINTABLE_CHARS) -> String:
	if length < 1:
		return ""
	if chars.length() < 1:
		return ""

	var src = chars.to_ascii_buffer()
	var dst = PackedByteArray()
	dst.resize(length)

	for i in range(length):
		dst[i] = src[randi_range(0, chars.length()-1)]

	return dst.get_string_from_ascii()


## Returns a random generated password.
static func generate_password(length: int) -> String:
	return generate_string(length, PASSWORD_CHARS)
