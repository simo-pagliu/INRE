To create the nomenclature you have to:
 1. Compile `main.tex` using custom recipie to complie bibliografy as well  
     "latex-workshop.latex.recipes": [
    

        {
            "name": "LuaLaTeX with Biber",
            "tools": [
                "lualatex",
                "biber",
                "lualatex",
                "lualatex"
            ]
        },
     ]
 2. Run `makeindex -s nomencl.ist -t main.nlg -o main.nls main.nlo` to compile the nomenclature
 3. Compile again