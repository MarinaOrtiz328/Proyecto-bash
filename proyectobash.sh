#!/bin/bash

#primer punto

	case $1 in
                -a)
                echo "Bienvenido a la guia rápida de Agile, para continuar seleccione un tema:"
                echo "1.SCRUM"
                echo "2. X.P"
                echo "3. Kanban"
                echo "4. Crystal"
                        ;;
                -t)
                echo "Bienvenido a la guía rápida de metodologías tradicionales, para continuar seleccione un tema:"
                echo "1. Cascada"
                echo "2. Espiral"
                echo "3. Modelo V"
                        ;;
                *)
                echo "Parametro no valido, vuelva a ejecutar"
		echo "Los parametros validos son: <-t> Agile, <-a> Metodologías tradicionales"
			;;
        esac

