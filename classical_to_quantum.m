function quant_rep = classical_to_quantum(col_stoch, unitary_mats)
if size(size(col_stoch), 2) ~= 2 || ~isequal(sum(col_stoch, 1), ones(1, size(col_stoch, 2)))
    throw(MException('quant_rep:invalidInput', 'Input not a valid HMM'));
else
    n = size(col_stoch, 2);
    m = size(col_stoch, 1);
    recips = 1 ./ sym(nonzeros(col_stoch)); % convert to fractional representation
    q = lcm(1, recips(1));
    for i = 2 : size(recips)
        q = lcm(q, recips(i));
    end
    q = double(q);
    %quant_rep = zeros(n * q * n, n * q * n);
    outer = cell([1, n]);
    for col = 1 : n
        mid = cell([1, q]);
        supp_idx = 1;
        for row = 1 : m
            for ntimes = 1 : q * sym(col_stoch(row, col))
                inner = unitary_mats(:, :, row);
                mid{1, supp_idx} = inner;
                supp_idx = supp_idx + 1;
            end
            %{
            for i = supp_idx : q
                mid{1, i} = zeros(m);%circshift(eye(m), m - 1);
            end
            %}
        end
        outer{1, col} = blkdiag(mid{1, :});
    end
    quant_rep = blkdiag(outer{1, :});
end
end