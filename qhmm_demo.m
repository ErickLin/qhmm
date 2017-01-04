% sample transition matrix
T = [.5 0 .5; .5 .5 0; 0 .5 .5];
% sample observation matrix
C = [0.3 0.4 0.9; 0.7 0.6 0.1];
disp('transition matrix: ');
disp(sym(T));
disp('observation probability matrix: ');
disp(sym(C));
n = size(T, 1);
m = size(C, 1);
% stochastic vector representing current state
p = [1; 0; 0];
disp('p_0 =');
disp(sym(p));
% run two iterations of transition and observation actions in classical setting
for i = 1 : 2
    p = T * p;
    disp(['p_', num2str(i), ' =']);
    disp(sym(p));
    y = C * p;
    disp(['y_', num2str(i), ' =']);
    disp(sym(y));
end

% convert transition matrix into quantum representation
U = classical_to_quantum(T, gen_unitary_mats(circshift(eye(n), 1)));
imagesc(U);
% convert observation matrix into quantum representation
Q = classical_to_quantum(C, gen_unitary_mats(circshift(eye(m), 1)));
%imagesc(Q);
% check that converting back to classical representations results in the original matrices
disp('transition matrix reconstructed: ');
disp(sym(quantum_to_classical(U, gen_unitary_mats(circshift(eye(n), 1)), n)));
disp('observation probability matrix reconstructed: ');
disp(sym(quantum_to_classical(Q, gen_unitary_mats(circshift(eye(m), 1)), n)));
p = [1; 0; 0];
% density matrix representing current state
p_dm = p * p';
disp('rho_p_0 =');
disp(sym(p_dm));
% run two iterations of transition and observation actions in quantum setting
for i = 1 : 2
    p_dm = transition(U, p_dm);
    [p_dm, observation] = observe(Q, p_dm, m);
    disp(['rho_p_', num2str(i), ' =']);
    disp(sym(p_dm));
    disp(['rho_y_', num2str(i), ' =']);
    disp(sym(observation));
end

%{
T2 = [1 0 3 2; 2 1 0 0; 0 1 0 1; 0 1 0 0] / 3;
disp(sym(T2));
n2 = size(T2, 1);
U2 = classical_to_quantum(T2, gen_unitary_mats(circshift(eye(n2), 1)));
imagesc(U2)
disp(sym(quantum_to_classical(U2, gen_unitary_mats(circshift(eye(n2), 1)), n2)));
%}
