DeclareRepresentation("EsFraccionRep", IsAttributeStoringRep, []);
DeclareCategory( "EsFraccion", EsFraccionRep and IsAdditiveElement);
TipoFraccion:=NewType(NewFamily("FamiliaFracciones"), EsFraccion);
DeclareAttribute("Numerador", EsFraccion);
DeclareAttribute("Denominador", EsFraccion);
DeclareOperation("Simplifica", [EsFraccion]);
DeclareProperty("EsPositivo", EsFraccion);
DeclareProperty("EsNoNegativo", EsFraccion);

Fraccion:=function(a,b)
    local r;
    if not(IsInt(a)) then 
        Error("El primer argumento debe ser un entero");
    fi;

    if not(IsInt(b)) or (b=0) then 
        Error("El segundo argumento debe ser un entero no nulo");
    fi;
    
    r:=Objectify(TipoFraccion, rec());
    SetNumerador(r,a);
    SetDenominador(r,b);
    return r;
end;

InstallMethod(EsPositivo, "es positivo para fracciones", [EsFraccion],
    function(x)
        return Numerador(x)*Denominador(x)>0;
end);

InstallMethod(EsNoNegativo, "es positivo para fracciones", [EsFraccion],
    function(x)
        return Numerador(x)*Denominador(x)>=0;
end);

InstallTrueMethod(EsNoNegativo, EsPositivo);

InstallMethod(Simplifica, "simplificación para fracciones", [EsFraccion], 
    function(x)
        local s, d;

        d:=Gcd(Numerador(x),Denominador(x));
        return Fraccion(Numerador(x)/d,Denominador(x)/d);
end);

InstallMethod(\=, "igualdad para fracciones", [EsFraccion, EsFraccion],
    function(x,y)
        return Numerador(x)*Denominador(y)=Numerador(y)*Denominador(x); 
end);

InstallMethod(\+, "suma de fracciones", [EsFraccion, EsFraccion],
    function(x,y)
        return Simplifica(Fraccion(Numerador(x)*Denominador(y)+ Numerador(y)*Denominador(x),Denominador(x)*Denominador(y)));
end);

InstallMethod(Display, "mostrar racionales", [EsFraccion],
    function(x)
        local l,s,i;

        l:=Maximum(Length(String(Numerador(x))),Length(String(Denominador(x))));
        s:="";
        for i in [1..l] do
            Append(s,"-");
        od;
        Print(Numerador(x),"\n");
        Print(s,"\n");
        Print(Denominador(x),"\n");
        return;
end);

InstallMethod(ViewString, "mostrar fracciones", [EsFraccion],
    function(x)
        return Concatenation(String(Numerador(x))," / ",String(Denominador(x)));
end);

InstallMethod(String, "fracciones a cadenas", [EsFraccion],
    function(x)
        return Concatenation(String(Numerador(x)),"/",String(Denominador(x)));
end);


#InstallMethod(PrintString, "mostrar fracciones", [EsFraccion],
#    function(x)
#        return Concatenation("El racional ",String(Numerador(x))," / ",String(Denominador(x)));
#end);
