function [new_state, observation] = observe(Q, p_dm, m) % dm - density matrix
n = size(p_dm, 1);
q = size(Q, 1) / (n * m);
randomness = normc(ones(q, 1));
randomness_dm = randomness * randomness';
observation = zeros(m, 1);
observation(1) = 1;
observ_dm = observation * observation';
sys_dm = kron(kron(p_dm, randomness_dm), observ_dm);
res = Q * sys_dm * Q';
new_state = partial_trace_right(partial_trace_right(res, m), q);
observation = partial_trace_left(partial_trace_left(res, n), q);
end