(module
  (import "console" "log" (func $log (param i32)))
  (func $main
  (local $i i32)
  (local $n i64)
  (local $length i32)
  (local $bestLength i32)
  (local $bestN i32)

  ;; Test all numbers, starting from 1
  (local.set $i (i32.const 1))
  (local.set $bestLength (i32.const 0))

  (loop $mainLoop
    (local.set $n (i64.extend_i32_s (local.get $i)))
    (local.set $length (i32.const 0))

    ;; Compute length of sequence
    (block $iterateDone
      (loop $iterate
        local.get $length
        i32.const 1
        i32.add
        local.set $length

        local.get $n
        i64.const 1
        i64.eq
        br_if $iterateDone

        ;; Compute next number in sequence
        local.get $n
        i64.const 2
        i64.rem_s
        i64.const 0
        i64.eq
        (if
          (then
            local.get $n
            i64.const 2
            i64.div_s
            local.set $n)
          (else
            i64.const 1
            i64.const 3
            local.get $n
            i64.mul
            i64.add
            local.set $n))
        br $iterate))

    ;; Record number and length, if best
    (block $isBest
      local.get $length
      local.get $bestLength
      i32.le_s
      br_if $isBest
      (local.set $bestLength (local.get $length))
      (local.set $bestN (local.get $i)))

    ;; Continue, if necessary
    local.get $i
    i32.const 1
    i32.add
    local.set $i

    local.get $i
    i32.const 1000000
    i32.lt_s
    br_if $mainLoop)

  ;; Finally, log the result
  local.get $bestN
  call $log)
  (start $main))
