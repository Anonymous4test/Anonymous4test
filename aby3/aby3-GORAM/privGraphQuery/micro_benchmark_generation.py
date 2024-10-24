from utils import *
import argparse

# get the parameters.
parser = argparse.ArgumentParser(description='Microbenchmark data generation')

parser.add_argument('--type', type=str, default= "complete", help='graph type')
parser.add_argument('--n', type=int, default=2**8, help='nodes number')
parser.add_argument('--e', type=int, default=-1, help='edges number')
parser.add_argument('--k', type=int, default=2**4, help='partition size')
parser.add_argument('--p', type=int, default=1, help='data provider numbers')

parser.add_argument('--file_prefix', type=str, default="./data/micro_benchmark/tmp_graph", help='file prefix')
parser.add_argument("--saving_type", type=str, default="2dpartition", help="saving type")
parser.add_argument("--tool", type=str, default="igraph", help="how to generate the graph, using nx or igraph.")
parser.add_argument("--hash_flag", type=bool, default=True, help="whether to hash the node id.")

args = parser.parse_args()

if(args.e > 0):
    raise ValueError("Edges number should be generated by the graph type.")
else:
    if(args.tool == "igraph"):
        graph = large_graph_generation(args.type, args.n)
    elif(args.tool == "nx"):
        graph = nx_graph_generation(args.type, args.n)
if(args.p == 1):
    graph_save(graph, args.file_prefix, args.saving_type, args.k, args.hash_flag)
else:
    graph_save_multi(graph, args.file_prefix, args.p, args.saving_type, args.k, args.hash_flag)