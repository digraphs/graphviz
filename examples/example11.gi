# https://graphviz.readthedocs.io/en/stable/examples.html
# """https://graphviz.org/Gallery/directed/unix.html"""
LoadPackage("graphviz");

t := GV_Digraph('TrafficLights');
GV_SetAttr(t, "engine=neato");
GV_SetAttr(t, "node [shape=\"box\"]");

for i in [2, 1] then
    GV_AddNode(t, StringFormatted("gy{}", i));
    GV_AddNode(t, StringFormatted("yr{}", i));
    GV_AddNode(t, StringFormatted("rg{}", i));
fi;

for i in (2, 1):
    t.node(f'gy{i:d}')
    t.node(f'yr{i:d}')
    t.node(f'rg{i:d}')

t.attr('node', shape='circle', fixedsize='true', width='0.9')
for i in (2, 1):
    t.node(f'green{i:d}')
    t.node(f'yellow{i:d}')
    t.node(f'red{i:d}')
    t.node(f'safe{i:d}')

for i, j in [(2, 1), (1, 2)]:
    t.edge(f'gy{i:d}', f'yellow{i:d}')
    t.edge(f'rg{i:d}', f'green{i:d}')
    t.edge(f'yr{i:d}', f'safe{j:d}')
    t.edge(f'yr{i:d}', f'red{i:d}')
    t.edge(f'safe{i:d}', f'rg{i:d}')
    t.edge(f'green{i:d}', f'gy{i:d}')
    t.edge(f'yellow{i:d}', f'yr{i:d}')
    t.edge(f'red{i:d}', f'rg{i:d}')

t.attr(overlap='false')
t.attr(label=r'PetriNet Model TrafficLights\n'
             r'Extracted from ConceptBase and layed out by Graphviz')
t.attr(fontsize='12')

t.view()