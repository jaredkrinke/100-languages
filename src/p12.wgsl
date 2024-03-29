@group(0) @binding(0) var<storage, read_write> output: array<i32>;

@compute @workgroup_size(1)
fn main(@builtin(global_invocation_id) global_id : vec3u) {
    var n: i32 = 0;
    for (var i: i32 = 1; ; i++) {
        n += i;
    
        let root: i32 = i32(sqrt(f32(n)));
        var divisors: i32 = 0;
        var j: i32 = 1;
        
        for (; j <= root; j++) {
            if ((n % j) == 0) {
                divisors += 2;
            }
        }

        if (j == root) {
            divisors++;
        }

        if (divisors > 500) {
            output[global_id.x] = n;
            break;
        }
    }
}
