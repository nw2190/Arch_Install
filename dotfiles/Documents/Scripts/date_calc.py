import datetime
import argparse

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--date", default="01/01/2019", type=str, help="Start date for calculation")
    parser.add_argument("--delta", default=0, type=int, help="Time delta / increment")
    args = parser.parse_args()

    start_date = datetime.datetime.strptime(args.date, "%m/%d/%y")
    end_date = start_date + datetime.timedelta(days=args.delta)
    print("\n{} / {} / {}\n".format(end_date.month,end_date.day,end_date.year))
