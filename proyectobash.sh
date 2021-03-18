#!/bin/bash



#segundo punto

seleccionar (){
    PS3="Usted esta en la sección $1, seleccione la opción que desea utilizar: "
    select opt in agregar buscar eliminar leer; do
    case $opt in
        agregar)
            read -p "Escribe el concepto nuevo: " nuevo_nombre
            read -p "Escribe su definición (sin saltos de linea): " nueva_definicion
            echo "[$nuevo_nombre] $nueva_definicion" >> "$1.inf"
        ;;
        buscar) 
            read -p "Inserte el concepto a buscar: " concepto
            grep "$concepto" "$1.inf"
        ;;
        eliminar)
            read -p "Escriba el concepto a eliminar: " concepto
            n_linea=$(grep -n -m 1 is $1.inf |sed  's/\([0-9]*\).*/\1/')
            
            #código de eliminado:
            ed -s hibro.inf <<!
            $n_linea d
            w
!
            #final 
            echo "eliminado"
            ;;
        leer)
            cat "$1.inf"
            ;;
        quit)
            break;;
        *) 
            echo "Invalid option $REPLY";;
    esac
    done
}

reinicio(){
    PS3="Quieres regresar al menu anterior o terminar la ejecucion?: "
    select opt in regresar terminar; do
    case $opt in
        regresar)
            read -p "Escribe el concepto nuevo: " nuevo_nombre
            read -p "Escribe su definición (sin saltos de linea): " nueva_definicion
            echo "[$nuevo_nombre] $nueva_definicion" >> "$1.inf"
        ;;
        terminar)
            break;;
        *) 
            echo "Invalid option $REPLY";;
    esac
    done
}

seleccionarA(){
    case $1 in
        1)
            seleccionar SCRUM;;
        2)
            seleccionar X.P;;
        3)
            seleccionar Kanaban;;
        4)
            seleccionar Crystal;;
        *)
            echo "Parametro no valido, vuelva a ejecutar"
    esac
}

seleccionarB(){
    case $1 in
        1)
            seleccionar CASCADA;;
        2)
            seleccionar Espiral;;
        3)
            seleccionar ModeloV;;
        *)
            echo "Parametro no valido, vuelva a ejecutar"
    esac
}

#primer punto

case $1 in
        -a)
        echo "Bienvenido a la guia rápida de Agile, para continuar seleccione un tema:"
        echo "1.SCRUM"
        echo "2. X.P"
        echo "3. Kanban"
        echo "4. Crystal"
        read -p "Selecciona una opcion: " n
        seleccionarA $n
                ;;
        -t)
        echo "Bienvenido a la guía rápida de metodologías tradicionales, para continuar seleccione un tema:"
        echo "1. Cascada"
        echo "2. Espiral"
        echo "3. Modelo V"
        read -p "Selecciona una opcion: " n
        seleccionarB $n
                ;;
        *)
        echo "Parametro no valido, vuelva a ejecutar"
        echo "Los parametros validos son: <-t> Agile, <-a> Metodologías tradicionales"
                ;;
esac

