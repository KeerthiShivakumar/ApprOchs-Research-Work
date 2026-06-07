function [y, cout] = Majority_adder(a, b, cin, k, n)
    a   = uint32(a);
    b   = uint32(b);
    cin = uint32(cin);
 
    lower_mask = uint32(2^k - 1);
    upper_mask = uint32(2^n - 1) - lower_mask;
 
    upper_a = bitand(a, upper_mask);
    upper_b = bitand(b, upper_mask);
    lower_a = bitand(a, lower_mask);
    lower_b = bitand(b, lower_mask);
 
    lower_result = uint32(0);
    carry        = cin;
 
    for bit = 0:(k-1)
        bit_mask = uint32(2^bit);
        bitA = uint32(bitand(lower_a, bit_mask) ~= 0);
        bitB = uint32(bitand(lower_b, bit_mask) ~= 0);
 
        maj     = uint32((bitA & bitB) | (bitB & carry) | (carry & bitA));
 
        % NOT majority: use xor with 1 to avoid type mismatch from ~
        sum_bit = bitxor(maj, uint32(1));
 
        lower_result = lower_result + sum_bit * bit_mask;
        carry = maj;
    end
 
    cout = carry;
 
    if upper_a ~= 0 || upper_b ~= 0
        upper_sum = upper_a + upper_b;
        y = upper_sum + lower_result;
    else
        y = lower_a + lower_b;
    end
end