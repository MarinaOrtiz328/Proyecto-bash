#!/bin/bash



#segundo punto

seleccionarA (){
    PS3="Usted esta en la sección $1, seleccione la opción que desea utilizar."
    select opt in agregar buscar eliminar leer; do
    case $opt in
        agregar)
            read -p "Escribe el concepto nuevo" nuevo_nombre
            read -p "Escribe su definición (sin saltos de linea)" nueva_definicion
            echo "[$nuevo_nombre] $nueva_definicion" >> "$1.inf"
        ;;
        buscar) 
            read -p "Inserte el concepto a buscar" concepto
            grep "$concepto" "$1.txt"
        ;;
        eliminar)
            read -p "Escriba el concepto a eliminar" concepto
            n_linea=$(grep -n -m 1 is text.txt |sed  's/\([0-9]*\).*/\1/')
            
            #código de eliminado:
            ed -s hibro.txt <<!
            $n_linea d
            w
!
            #final 
            echo "eliminado"

            ;;
        leer)
            cat "$1.inf"
        quit)
            break;;
        *) 
            echo "Invalid option $REPLY";;
    esac
    done
}

seleccionar(){
    case $1 in
        1)
            seleccionarA SCRUM;;
        2)
            seleccionarA X.P;;
        3)
            seleccionarA Kanaban;;
        4)
            seleccionarA Crystal;;
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
        seleccionar $n
                ;;
        -t)
        echo "Bienvenido a la guía rápida de metodologías tradicionales, para continuar seleccione un tema:"
        echo "1. Cascada"
        echo "2. Espiral"
        echo "3. Modelo V"
        read -p "Selecciona una opcion: " n
                ;;
        *)
        echo "Parametro no valido, vuelva a ejecutar"
        echo "Los parametros validos son: <-t> Agile, <-a> Metodologías tradicionales"
                ;;
esac

