% traces out the inner subsystem
% sys is the density matrix of the original system
% dim is the size of the inner subsystem
function newsys = partial_trace_right(sys, dim)
    n = size(sys, 1) / dim;
    newsys = zeros(n);
    for row = 1 : n
        for col = 1 : n
            newsys(row, col) = trace(sys(dim*(row-1)+1 : dim*row, dim*(col-1)+1 : dim*col));
        end
    end
end
