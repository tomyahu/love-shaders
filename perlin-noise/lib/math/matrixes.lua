local lib = {}

lib.basic_vectors = {{1,1}, {-1,-1}, {1,-1}, {-1,1}, {1,1}, {-1,-1}, {1,-1}, {-1,1}}

function lib.createRandomPerlinNoiseMatrix(rows, cols)
    local matrix = {}

    for i = 1,rows do
        matrix[i] = {}
        for j = 1, cols do
            matrix[i][j] = lib.basic_vectors[math.random(1, (# lib.basic_vectors))]
        end
    end

    return matrix
end

return lib