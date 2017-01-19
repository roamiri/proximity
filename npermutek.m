function [permutedMatrix, index] = npermutek(N, K)
    %NPERMUTEK Permutation of elements with replacement/repetition.
    % permutedMatrix = NPERMUTEK(N,K) returns all possible samplings of
    % length K from vector N of type: ordered sample with replacement. MAT
    % has size (numel(N)^K)-by-K, where K must be a scalar.
    % [permutedMatrix, Index] = NPERMUTEK(N,K) also returns Index such that
    % permutedMatrix = N(Index). N may be of any numeric class, char, cell,
    % struct or custom objects.
    %
    %
    % Syntax: [permutedMatrix, Index] = npermutek(N, K)
    %
    % Inputs:
    %   N:                  The input to be permuted, can be of any numeric
    %                       class, char, cell, struct.
    %   K:                  The number of permutations, needs to be
    %                       numeric, scalar, real, positiv.
    %
    % Outputs:
    %	permutedMatrix:     The permuted Matrix
    %   index         :     The indices from the input in the permuted
    %                       Matrix
    %
    % Examples:
    %         permutedMatrix = npermutek([2 4 5],2)
    %
    %  permutedMatrix =
    % 
    %       2     2
    %       2     4
    %       2     5
    %       4     2
    %       4     4
    %       4     5
    %       5     2
    %       5     4
    %       5     5
    %
    % NPERMUTEK also works on characters.
    %
    %         permutedMatrix = npermutek(['a' 'b' 'c'],2)
    %  permutedMatrix =
    %        
    %      aa
    %      ab
    %      ac
    %      ba
    %      bb
    %      bc
    %      ca
    %      cb
    %      cc
    %
    % NPERMUTEK also works on cells.
    %
    %         aCell = {'a', 2; 'd', {[1 :10]}}
    %
    %     aCell = 
    % 
    %         'a'    [       2]
    %         'd'    {1x1 cell}
    %
    %         permutedMatrix = npermutek(aCell,2)
    %     permutedMatrix = 
    % 
    %         'a'           'a'       
    %         'a'           'd'       
    %         'a'           [       2]
    %         'a'           {1x1 cell}
    %         'd'           'a'       
    %         'd'           'd'       
    %         'd'           [       2]
    %         'd'           {1x1 cell}
    %         [       2]    'a'       
    %         [       2]    'd'       
    %         [       2]    [       2]
    %         [       2]    {1x1 cell}
    %         {1x1 cell}    'a'       
    %         {1x1 cell}    'd'       
    %         {1x1 cell}    [       2]
    %         {1x1 cell}    {1x1 cell}
    %
    % See also: perms, nchoosek
    %
    %
    % About and copyright
    % Author: Adrian Etter
    % http://www.econ.uzh.ch/faculty/etter.html
    % E-Mail: etteradrian@gmail.com
    % © Adrian Etter
    % Version 1.0 2013/Feb/28
    %
    % This function is based on the work of Matt Fig's npermutek,
    % especially the help and description was just copied out of his script:
    % See:
    % http://www.mathworks.ch/matlabcentral/fileexchange/11462-npermutek
    % Also on the web: http://mathworld.wolfram.com/BallPicking.html See
    % the section on Enumerative combinatorics below:
    % http://en.wikipedia.org/wiki/Permutations_and_combinations Author:
    % Matt Fig Contact:  popkenai@yahoo.com

    %
    assert(nargin == 2, 'NPERMUTEK:nrargin', 'NPERMUTEK requires two arguments. See help.');

    % Test K
    assert(numel(K) == 1 ...
            && floor(K) == K ...
            && gt(K, 0) ...
            && isreal(K), ... 
        'NPERMUTEK:K', ...
        'Second argument K needs to be real positive and scalar integer. See help.');
    
    % get input matrix
    Input = N(:);

    nrElements          = numel(N);
    nrRows              = nrElements ^ K;    
    inputIndices        = (1:nrElements).';    
    index               = reshape((1:nrRows * K).', nrRows, K); % allocate space for output
    
    % Create permutation matrix
    for iColumn = 1 : K
        row                     = repmat(inputIndices(:,ones(1, nrElements^(iColumn - 1))).', 1, nrElements ^ (K - iColumn));
        index(:, iColumn) = row(:);
    end   
    % flip to common format
    index = fliplr(index);    
    % assign output
    permutedMatrix = Input(index);
    
end
