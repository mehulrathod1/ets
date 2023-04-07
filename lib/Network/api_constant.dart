class ApiConstant {
  static const baseUrl = "https://devapi.employeetrackingsolutions.com/";

  // --------------------------------- company portal --------------------------------------------------------

  static String userToken = '';
  static const companyLogin = 'company-login/';
  static const companyProfile = 'company/get-profile';
  static const companyAllEmployee = 'company/get-employee-list?show=10&searchName=&page=';
  static const companyDepartment = 'company/department-list/';
  static const companyContacts = 'company/get-all-contact?show=10&searchName=&page=';
  static const addCompanyContacts = 'company/add-contact/';
  static const getCompanyOrder = 'company/get-all-order?show=10&searchName=&page=';
  static const getCompanyTask = 'company/get-all-task?show=10&searchName=&page=';
  static const deleteCompanyEmployee = 'company/get-profile';
  static const companyNoteList = 'company/get-all-notes?show=10&searchName=&page=';
  static const companyAddNote = 'company/add-notes/';
  static const companyViewAttendance = 'company/view-attendance/281/';
  static const companyViewHours = 'company/view-hours-employee/281/2022-11-18/';
  static const companyViewImage = 'company/view-image-employee/281/2022-11-18/';
  static const companyViewMap = 'company/view-map-employee/281/2022-11-18/';
  static const sendLocationRequest = 'company/send_live_location_request_employee.php?id=281';
  static const sendCallRequest = 'company/send_call_for_attendance_request.php?id=281';
  static const companyDeleteContact = 'company/delete-contact/';
  static const companyDeleteTask = 'company/delete-task/';
  static const companyDeleteEmployee = 'company/delete-employee-company?id=';
  static const companyDeleteDepartment = 'company/delete-department/';
  static const companyAddDepartment = 'company/add-department';

  // --------------------------------- employee portal --------------------------------------------------------

  static const employeeLogin = 'employee-login/';
  static const employeeSendHourRequest = 'employee/send-fix-hours-request-employee/';
  static const employeeGetHourRequest = 'employee/get-hour-request-list-employee?show=10&searchName=&page=';
  static const employeeAttendanceHistory = 'employee/attendance-history-employee?show=10&startdate=&enddate=&page=';
  static const employeeContactList = 'employee/view-contact-list';
  static const employeeAddContact = 'employee/add-contact';
  static const employeeOrderList = 'employee/view-orders-lists';
  static const employeeEstimateList = 'employee/view-estimate-lists';
  static const employeeNoteList = 'employee/view-notes-list';
  static const employeeAddNote = 'employee/edit-note/';
  static const employeeInvoice = 'employee/view-invoice-lists';
  static const employeeAddOrder = 'employee/add-orders';
  static const employeeGetImage = 'employee/view-image-employee?date=2023-02-03';
  static const employeeGetMap = 'employee/view-map-employee?date=2023-02-03';
  static const employeeNotification = 'employee/get-notification/';
  static const employeeTaskList = 'employee/view-task-list';
  static const employeeAddTask = 'employee/add-task';
  static const employeeTaskDetail = 'employee/edit-tasks/61';
  static const employeeDeleteTask = 'employee/delete-task/';
  static const employeeDeleteNote = 'employee/delete-note/';
  static const employeeDeleteOrder = 'employee/delete_order.php?id=';

  // --------------------------------- sales portal --------------------------------------------------------

  static const salesLogin = 'sales-login/';
  static const salesDeleteAgent = 'SALES/delete-agent/';
  static const salesAgent = 'SALES/view-all-agent?show=10&startdate=&enddate=&searchName=&page=';
}
