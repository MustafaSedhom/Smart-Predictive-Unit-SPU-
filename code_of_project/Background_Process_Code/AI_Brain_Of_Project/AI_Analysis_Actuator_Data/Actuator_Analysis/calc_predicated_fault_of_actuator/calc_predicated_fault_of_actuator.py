def calc_Actuator_predict_fault_days( health_values:list):
    if len(health_values) < 2:
        return None
    # health loss per day
    daily_drop = float(health_values[1]) - float(health_values[-1])
    number_of_days = len(health_values) - 1
    avg_drop_per_day = daily_drop / number_of_days
    current_health = float(health_values[-1])
    critical_health = 20
    if avg_drop_per_day <= 0:
        return 99
    predicted_days = (
        current_health - critical_health
    ) / avg_drop_per_day

    return round(predicted_days, 2)