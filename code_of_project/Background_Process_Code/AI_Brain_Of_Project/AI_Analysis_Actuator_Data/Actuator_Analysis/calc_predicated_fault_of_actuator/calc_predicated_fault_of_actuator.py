def calc_Actuator_predict_fault_days(health_values: list):

    if len(health_values) < 2:
        return None

    # first and latest health values
    first_health = float(health_values[0])
    current_health = float(health_values[-1])

    # total health drop
    total_drop = first_health - current_health

    # number of days between readings
    number_of_days = len(health_values) - 1

    # average health loss per day
    avg_drop_per_day = total_drop / number_of_days

    critical_health = 20

    # no degradation
    if avg_drop_per_day <= 0:
        return 99

    # already critical
    if current_health <= critical_health:
        return 0

    # predicted remaining days
    predicted_days = (
        current_health - critical_health
    ) / avg_drop_per_day

    return round(predicted_days, 2)