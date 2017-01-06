% sample transition matrix
T = [.5 0 .5; .5 .5 0; 0 .5 .5];
% sample observation matrix
O = [0.3 0.4 0.9; 0.7 0.6 0.1];
disp('transition matrix: ');
disp(sym(T));
disp('observation probability matrix: ');
disp(sym(O));
n = size(T, 1);
m = size(O, 1);
% stochastic vector representing current state
x = [1; 0; 0];
disp('x_0 =');
disp(sym(x));
% run two iterations of transition and observation actions in classical setting
for i = 1 : 2
    x = T * x;
    disp(['x_', num2str(i), ' =']);
    disp(sym(x));
    y = O * x;
    disp(['y_', num2str(i), ' =']);
    disp(sym(y));
end

% convert transition matrix into quantum representation
U = classical_to_quantum(T, gen_unitary_mats(circshift(eye(n), 1)));
imagesc(U);
% convert observation matrix into quantum representation
Q = classical_to_quantum(O, gen_unitary_mats(circshift(eye(m), 1)));
%imagesc(Q);
% check that converting back to classical representations results in the original matrices
disp('transition matrix reconstructed: ');
disp(sym(quantum_to_classical(U, gen_unitary_mats(circshift(eye(n), 1)), n)));
disp('observation probability matrix reconstructed: ');
disp(sym(quantum_to_classical(Q, gen_unitary_mats(circshift(eye(m), 1)), n)));
x = [1; 0; 0];
% density matrix representing current state
x_dm = x * x';
disp('rho_x_0 =');
disp(sym(x_dm));
% run two iterations of transition and observation actions in quantum setting
for i = 1 : 2
    x_dm = transition(U, x_dm);
    [x_dm, observation] = observe(Q, x_dm, m);
    disp(['rho_x_', num2str(i), ' =']);
    disp(sym(x_dm));
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
