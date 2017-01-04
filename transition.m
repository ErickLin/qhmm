function new_state = transition(U, p_dm) % dm - density matrix
n = size(p_dm, 1);
q = size(U, 1) / (n * n);
randomness = normc(ones(q, 1));
randomness_dm = randomness * randomness';
next_p = zeros(n, 1);
next_p(1) = 1;
next_p_dm = next_p * next_p';
sys_dm = kron(kron(p_dm, randomness_dm), next_p_dm);
res = U * sys_dm * U';
new_state = partial_trace_left(partial_trace_left(res, n), q);
end