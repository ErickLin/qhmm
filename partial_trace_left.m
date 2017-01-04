% traces out the outer subsystem
% sys is the density matrix of the original system
% dim is the size of the outer subsystem
function newsys = partial_trace_left(sys, dim)
    n = size(sys, 1) / dim;
    newsys = zeros(n);
    for i = 1 : dim
        newsys = newsys + sys(n * (i - 1) + 1 : n * i, n * (i - 1) + 1 : n * i);
    end
end
