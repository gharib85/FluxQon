function pn=ptrace(p,d,n)
%% Partial Trace
%  pn=ptrace(p,d,n) computes the partial trace of the density matrix, p, over
%  the subsystem of index n. The integer vector d is the list of the subspace
%  dimensions. This function is a complementary operation to subdsmat.
%
% See also: subdsmat.
%
% Copyright: Herianto Lim
% http://heriantolim.com/
% First created: 03/08/2017
% Last modified: 03/08/2017

assert(iscomplexmatrix(p),...
	'QuantMech:DsMat:ptrace:InvalidInput',...
	'Input to the density matrix must be a complex matrix.');
assert(isintegervector(d),...
	'QuantMech:DsMat:ptrace:InvalidInput',...
	'Input to the subspace dimensions must be a positive integer vector.');
D=prod(d);
assert(D==size(p,1),...
	'QuantMech:DsMat:ptrace:InvalidInput',...
	['The product of the elements in the subspace dimension must be ',...
		'equal to the dimension of the density matrix.']);
N=numel(d);
assert(isintegerscalar(n) && n>0 && n<=N,...
	'QuantMech:DsMat:ptrace:InvalidInput',...
	['Input to the subspace index must be an integer scalar between 1 ',...
		'and the total number of the subspaces.']);

if N==1
	pn=trace(p);
	return
end
d=[prod(d(1:(n-1))),d(n),prod(d((n+1):N))];

D=d(2)*d(3);
pn=zeros(d(1)*d(3));
for i=1:d(1)
	for j=1:d(1)
		for m=1:d(2)
			for k=1:d(3)
				for l=1:d(3)
					pn((i-1)*d(3)+k,(j-1)*d(3)+l)=pn((i-1)*d(3)+k,(j-1)*d(3)+l) ...
						+p((i-1)*D+(m-1)*d(3)+k,(j-1)*D+(m-1)*d(3)+l);
				end
			end
		end
	end
end

end