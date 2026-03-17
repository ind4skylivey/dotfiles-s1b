# Waybar Multi-Monitor Configuration

## Monitors Setup

Tu sistema tiene 3 monitores:
- **DP-1**: Pantalla primaria (2016x1134, horizontal)
- **DP-2**: ASUS (1080x1920, vertical)
- **HDMI-A-1**: Pantalla secundaria (2016x1134, horizontal)

## Archivos de Configuración

### Por Monitor
- `config-dp1.jsonc` - Configuración completa para DP-1 (primaria)
- `config-dp2.jsonc` - Configuración compacta para DP-2 (vertical ASUS)
- `config-hdmi.jsonc` - Configuración completa para HDMI-A-1

### Estilos CSS
- `style-dp1.css` - Fuente 12px para DP-1
- `style-dp2.css` - Fuente 10px para DP-2 (compacto)
- `style-hdmi.css` - Fuente 12px para HDMI-A-1

## Lanzar Waybar

### Opción 1: Todas las pantallas (recomendado)
```bash
~/.config/waybar/launch-multi.sh
```

### Opción 2: Una pantalla específica
```bash
waybar -c ~/.config/waybar/config-dp1.jsonc -s ~/.config/waybar/style-dp1.css &
waybar -c ~/.config/waybar/config-dp2.jsonc -s ~/.config/waybar/style-dp2.css &
waybar -c ~/.config/waybar/config-hdmi.jsonc -s ~/.config/waybar/style-hdmi.css &
```

### Opción 3: Matar todas las instancias
```bash
killall waybar
```

## Autostart en KDE Plasma

Para que waybar se lance automáticamente:

### Método 1: Crear archivo de autostart
```bash
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/waybar.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Waybar
Exec=~/.config/waybar/launch-multi.sh
NoDisplay=true
EOF
```

### Método 2: Agregar a ~/.xprofile o ~/.bashrc
```bash
echo '~/.config/waybar/launch-multi.sh &' >> ~/.xprofile
```

## Modificar Configuración

### Agregar módulo a una pantalla específica
Edita el archivo `config-dp*.jsonc` correspondiente:
1. Agrega el módulo a `modules-left`, `modules-center` o `modules-right`
2. Define su configuración en la sección del módulo
3. Recarga: `killall waybar && ~/.config/waybar/launch-multi.sh`

### Cambiar estilo de una pantalla
Edita el archivo `style-dp*.css` correspondiente:
1. Modifica los colores, padding, fuentes, etc.
2. Recarga: `killall waybar && ~/.config/waybar/launch-multi.sh`

## Particularidades de DP-2 (ASUS vertical)

La configuración de DP-2 es minimalista porque el espacio es limitado:
- Altura reducida a 24px (vs 34px en otros)
- Fuente 10px (vs 12px en otros)
- Sin módulos en `modules-center` (solo essentials)
- Menos módulos en general para evitar overflow

Si quieres agregar más módulos a DP-2, considera:
- Reducir fuente más
- Aumentar altura de la barra
- Remover alguns módulos de otros

## Troubleshooting

### Barra no aparece en un monitor
Verifica que el nombre del monitor es correcto:
```bash
xrandr --listactivemonitors
```

### Texto cortado en DP-2
- Reduce la fuente en `style-dp2.css`
- Aumenta la altura en `config-dp2.jsonc`
- Remueve módulos menos usados

### Múltiples barras en el mismo monitor
Ejecuta:
```bash
killall waybar
sleep 1
~/.config/waybar/launch-multi.sh
```
