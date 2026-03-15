include("../src/LincsProject.jl")
using DataFrames


# Name output file with LINCS landmark gene data
out_dir = "./data"
mkpath(out_dir)
out_file = joinpath(out_dir, "lincs.jld2")

# Create output file
l = LincsProject.Lincs(joinpath("/home/muninn/scratch/lincs_beta/", ""), "level3_beta_all_n3026460x12328.gctx", out_file)

trt_cp = l[:pert_type, :trt_cp]

lcp = l[trt_cp]
gdf = groupby(lcp, :cell_mfc_name)

cp_count = combine(gdf, :pert_id => (x -> unique(x) |> length) => :nb_cp)
z = sort(cp_count, :nb_cp; rev=true)
cnv = z[1:10,:cell_mfc_name]

i2s = Dict([row.pert_id => row.canonical_smiles for row in eachrow(l.compound)]);
for a in eachindex(cnv)
    pa = lcp[lcp.cell_mfc_name .== cnv[a], :pert_id] |> unique
    sa = Set([i2s[p] for p ∈ pa])
    for b in (a+1:length(cnv))
        pb = lcp[lcp.cell_mfc_name .== cnv[b], :pert_id] |> unique
        sb = Set([i2s[p] for p ∈ pb])
        ci = sa ∩ sb
        println("$(cnv[a]) $(cnv[b]) -> $(length(ci))")
    end
end

