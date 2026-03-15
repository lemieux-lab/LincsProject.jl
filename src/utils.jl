using DataFrames


Base.getindex(d::Lincs, sym::Symbol, value::Symbol) = d.inst[!, sym] .== value
Base.getindex(d::Lincs, sym::Symbol, values::Vector{Symbol}) = [v in values for v in d.inst[!, sym]]
Base.getindex(d::Lincs, sym::Symbol, value::String) = d.inst[!, sym] .== value
Base.getindex(d::Lincs, sym::Symbol, values::Vector{String}) = [v in values for v in d.inst[!, sym]]
Base.getindex(d::Lincs, v::BitVector) = d.inst[v, :]

Base.getindex(df::DataFrame, sym::Symbol, value::Symbol) = df[!, sym] .== value
Base.getindex(df::DataFrame, sym::Symbol, values::Vector{Symbol}) = [v in values for v in df[!, sym]]
Base.getindex(df::DataFrame, sym::Symbol, value::String) = df[!, sym] .== value
Base.getindex(df::DataFrame, sym::Symbol, values::Vector{String}) = [v in values for v in df[!, sym]]
Base.getindex(df::DataFrame, v::BitVector) = df[v, :]




