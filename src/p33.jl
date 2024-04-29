p = 1
for a = 0:9
    for b = 0:9
        for s = 0:9
            # Try all possible arrangements
            # sa/sb
            if s != 0 && b != 0
                r1 = ((10 * s) + a) // ((10 * s) + b)
                r2 = a // b
                if r1 < 1 && r1 == r2
                    global p *= r2
                end
            end
            
            # as/sb
            if s != 0 && a != 0 && b != 0
                r1 = ((10 * a) + s) // ((10 * s) + b)
                r2 = a // b
                if r1 < 1 && r1 == r2
                    global p *= r2
                end
            end
            
            # as/bs
            if a != 0 && b != 0 && s != 0
                r1 = ((10 * a) + s) // ((10 * b) + s)
                r2 = a // b
                if r1 < 1 && r1 == r2
                    global p *= r2
                end
            end
            
            # sa/bs
            if s != 0 && b != 0
                r1 = ((10 * s) + a) // ((10 * b) + s)
                r2 = a // b
                if r1 < 1 && r1 == r2
                    global p *= r2
                end
            end
        end
    end
end

println(denominator(p))
