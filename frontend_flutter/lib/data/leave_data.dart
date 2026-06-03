class LeaveData {

  static List<Map<String, dynamic>> leaves = [];

  static void addLeave(Map<String, dynamic> leave) {
    leaves.add(leave);
  }

  static List<Map<String, dynamic>> getLeaves() {
    return leaves;
  }
}