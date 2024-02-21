# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://www.graphviz.org/Gallery/gradient/angles.html"""

LoadPackage("graphviz");
g := GV_Digraph("G");
GV_SetAttr(g, "bgcolor", "blue");

cluster1 := GV_AddSubgraph(g, IsGVDigraph, "cluster_1");
GV_SetAttr(cluster1, "fontcolor", "white");
GV_SetAttr(cluster1, "node[shape=circle, style=filled, fillcolor=\"white:black\", gradient=360, label=\"n9:n360\", fontcolor=black]");
GV_AddNode(cluster1, "n9");

for i in []

    for i, a in zip(range(8, 0, -1), range(360 - 45, -1, -45)):
        c.attr('node', gradientangle=f'{a:d}', label=f'n{i:d}:{a:d}')
        c.node(f'n{i:d}')
    c.attr(label='Linear Angle Variations (white to black gradient)')

with g.subgraph(name='cluster_2') as c:
    c.attr(fontcolor='white')
    c.attr('node', shape='circle', style='radial', fillcolor='white:black',
           gradientangle='360', label='n18:360', fontcolor='black')
    c.node('n18')
    for i, a in zip(range(17, 9, -1), range(360 - 45, -1, -45)):
        c.attr('node', gradientangle=f'{a:d}', label=f'n{i:d}:{a:d}')
        c.node(f'n{i:d}')
    c.attr(label='Radial Angle Variations (white to black gradient)')

g.edge('n5', 'n14')

g.view()