List<G> expandedList<G>(List<G> inputList, G newElement) {
  List<G> returnList = inputList;
  inputList.add(newElement);
  return returnList;
}