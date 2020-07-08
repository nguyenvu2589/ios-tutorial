import csv
import os
import shutil
from os import walk


dog_breeds_dict = {}

labels_file = "labels.csv"
base_write_path = "training"
error_file = "unable_to_move.csv"

def create_folder(folder_path):
	if not os.path.exists(folder_path):
		os.makedirs(folder_path)
	
def write_to(file_label, file_name, dog_breed):
	f = open(file_label, "a")
	f.write(f"{file_name},{dog_breed}\n")
	f.close()

def create_base_folder():
	create_folder(base_write_path)
	create_folder(f"{base_write_path}/training")
	create_folder(f"{base_write_path}/testing")

def add_breed_to_dict(dog_breed):
	if dog_breed in dog_breeds_dict:
		dog_breeds_dict[dog_breed] += 1
	else:
		dog_breeds_dict[dog_breed] = 1

def get_file_type(dog_breed):
	if dog_breeds_dict[dog_breed] < 13:
		return "testing"
	return "training"

def move_file(file_name, dog_breed):
	file_type = get_file_type(dog_breed)

	source = f"train/{file_name}.jpg"
	destination = f"{base_write_path}/{file_type}/{dog_breed}/{file_name}.jpg"

	create_folder(f"{base_write_path}/{file_type}/{dog_breed}")
	try:
		shutil.move(source, destination)
	except:
		#write fail result to  error file
		write_to(error_file, file_name, dog_breed)


def process_data(file_name, dog_breed):
	add_breed_to_dict(dog_breed)
	move_file(file_name, dog_breed)

def pre_process_data():
	with open(labels_file) as csvfile:
		readCSV = csv.reader(csvfile, delimiter=',')
		for row in readCSV:
			process_data(file_name=row[0], dog_breed=row[1])



if __name__ == '__main__':
	
	create_base_folder()
	pre_process_data()

