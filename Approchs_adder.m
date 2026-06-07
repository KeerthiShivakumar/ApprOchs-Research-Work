function y = Approchs_adder(a, b, k, n)
    a = uint32(a);
    b = uint32(b);
    lower_mask = uint32(2^k - 1);
    upper_mask = uint32(2^n - 1) - lower_mask;
    upper_a = bitand(a, upper_mask);
    upper_b = bitand(b, upper_mask);
    if upper_a ~= 0 || upper_b ~= 0
        upper_sum = upper_a + upper_b;
        lower_or  = bitor(bitand(a, lower_mask), bitand(b, lower_mask));
        y = upper_sum + lower_or;
    else
        y = bitand(a, lower_mask) + bitand(b, lower_mask);
    end
end