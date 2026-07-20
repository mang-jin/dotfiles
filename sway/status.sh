# #!/bin/sh

# echo "{\"version\":1}";
# echo "[";

# first=1

# LAST_NOT=100

# while true; do
#     [ "$first" -eq 0 ] && echo ',' || first=0

#     DATE=$(date +'%Y-%m-%d %X');
#     VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}');
#     TEA=$(cat /sys/class/thermal/thermal_zone*/temp | awk '{printf "%.1f°C ", $1/1000}');
#     HP=$(cat /sys/class/power_supply/BAT1/capacity);
#     STATUS=$(cat /sys/class/power_supply/BAT1/status);
#     WIFI_NAME=$(nmcli dev show wlp3s0 | grep GENERAL.CONNECTION | awk '{printf $2}');
#     WIFI_CONN=$(nmcli dev show wlp3s0 | grep GENERAL.STATE | sed -E 's/.*[0-9]\s\((.*)\).*/\1/');
#     WIFI_COLOR="#00FFFF"

#     if [ "$WIFI_CONN" != "connected" ]; then
#         WIFI_COLOR="#FF0000"
#     fi

#     if [ "$STATUS" = "Discharging" ] && [ "$HP" -le "25" ]; then
#         if [ "$LAST_NOT" -ne "$HP" ]; then
#             notify-send -u critical "배터리 부족!"
#             LAST_NOT=$HP
#         fi
#     fi

#     if [ "$STATUS" != "Discharging" ]; then
#         LAST_NOT=100
#     fi

#     HP_COLOR="#FFFFFF"
#     case "$STATUS" in
#         Charging)
#             HP_COLOR="#FFFF00"
#             ;;
#         Discharging)
#             ;;
#         Full)
#             HP_COLOR="#00FF00"
#             ;;
#         *)
#             HP_COLOR="#FF0000"
#             ;;
#     esac
#     echo "["
#     echo "{\"full_text\": \"Hp: ${HP}(${STATUS})\",\"color\":\"${HP_COLOR}\"},"
#     echo "{\"full_text\": \"Wifi: ${WIFI_NAME}(${WIFI_CONN})\",\"color\":\"${WIFI_COLOR}\"},"
#     echo "{\"full_text\": \"Pancake: ${TEA}\"},"
#     echo "{\"full_text\": \"Ear Destroyer: ${VOL}\"},"
#     echo "{\"full_text\": \"${DATE}\"}"
#     echo "]"
#     sleep 1;
# done


#!/bin/sh

echo '{"version":1}'
echo '['

first=1
LAST_NOT=100

while true; do
    [ "$first" -eq 0 ] && echo ',' || first=0

    DATE=$(date +'%Y-%m-%d %X')
    VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
    TEA=$(cat /sys/class/thermal/thermal_zone*/temp |
        awk '{printf "%.1f°C ", $1 / 1000}')
    HP=$(cat /sys/class/power_supply/BAT1/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT1/status)

    WIFI_NAME=$(
        nmcli dev show wlp3s0 |
            grep GENERAL.CONNECTION |
            awk '{printf $2}'
    )

    WIFI_CONN=$(
        nmcli dev show wlp3s0 |
            grep GENERAL.STATE |
            sed -E 's/.*[0-9]\s\((.*)\).*/\1/'
    )

    # 흰 배경에서도 잘 보이는 짙은 파랑
    WIFI_COLOR="#005A9C"

    if [ "$WIFI_CONN" != "connected" ]; then
        WIFI_COLOR="#B00020"
    fi

    if [ "$STATUS" = "Discharging" ] && [ "$HP" -le 25 ]; then
        if [ "$LAST_NOT" -ne "$HP" ]; then
            notify-send -u critical "배터리 부족!"
            LAST_NOT=$HP
        fi
    fi

    if [ "$STATUS" != "Discharging" ]; then
        LAST_NOT=100
    fi

    # 기본 텍스트는 거의 검정
    HP_COLOR="#202020"

    case "$STATUS" in
        Charging)
            # 밝은 노랑 대신 짙은 주황
            HP_COLOR="#A05A00"
            ;;
        Discharging)
            HP_COLOR="#202020"
            ;;
        Full)
            # 밝은 초록 대신 짙은 초록
            HP_COLOR="#167000"
            ;;
        *)
            HP_COLOR="#B00020"
            ;;
    esac

    echo '['
    echo "{\"full_text\":\"Hp: ${HP}(${STATUS})\",\"color\":\"${HP_COLOR}\"},"
    echo "{\"full_text\":\"Wifi: ${WIFI_NAME}(${WIFI_CONN})\",\"color\":\"${WIFI_COLOR}\"},"
    echo "{\"full_text\":\"Pancake: ${TEA}\",\"color\":\"#303030\"},"
    echo "{\"full_text\":\"Ear Destroyer: ${VOL}\",\"color\":\"#303030\"},"
    echo "{\"full_text\":\"${DATE}\",\"color\":\"#202020\"}"
    echo ']'

    sleep 1
done
