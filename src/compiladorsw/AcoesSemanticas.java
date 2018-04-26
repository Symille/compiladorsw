package compiladorsw;

import antlrsw.GramaticaswBaseListener;
import antlrsw.GramaticaswParser;
import java.util.HashMap;
import java.util.Map;

public class AcoesSemanticas extends GramaticaswBaseListener {
    private Map<String, Integer> tabSimb = new HashMap<String, Integer>();    

    public Map<String, Integer> getTabSimb() {
        return tabSimb;
    }

    public void setTabSimb(Map<String, Integer> tabSimb) {
        this.tabSimb = tabSimb;
    }

    public void exitDecVars(GramaticaswParser.DecVarsContext ctx) { 
        for (Object el : ctx.listaId().ID()) {
            if (!tabSimb.containsKey(el.toString())) {
                tabSimb.put(el.toString(), ctx.tipo().t);
            } else {
                System.out.println("Id já declarado: "+el.toString()); 
            }
        } 
    }
}
