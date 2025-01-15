#!/usr/bin/env rexx

/* Need precision to at least accurately handle exponent * log(base) */
numeric digits 15

signal on notready

line = 0
biggest_log = 0
biggest_line = 0

do forever
	parse pull base "," exp
	line = line + 1

	/* Only need to compute logarithm... but Rexx doesn't have a log function,
	 * so approximate using the slowest, most naive algorithm possible... */
	log_base = 1.00001
	log_of_exp = 1
	v = log_base
	do while v < base
		v = v * log_base
		log_of_exp = log_of_exp + 1
	end

	/* exponent * log(base) */
	log = exp * log_of_exp
	say line ":" log_of_exp

	if log > biggest_log then
	do
		biggest_log = log
		biggest_line = line
	end
end

notready:
say biggest_line

