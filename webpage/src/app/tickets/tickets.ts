import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-tickets',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-200 dark:border-slate-700 overflow-hidden flex flex-col h-full transition-colors duration-300">
      
      <div class="p-6 border-b border-slate-100 dark:border-slate-700 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <h2 class="text-lg font-bold text-slate-800 dark:text-white">Ticket Viewer</h2>
        
        <div class="flex bg-slate-100 dark:bg-slate-700/50 p-1 rounded-lg self-start sm:self-auto overflow-x-auto max-w-full">
          <button *ngFor="let tab of tabs" 
                  (click)="activeTab = tab"
                  [class.bg-white]="activeTab === tab"
                  [class.text-primary-600]="activeTab === tab"
                  [class.shadow-sm]="activeTab === tab"
                  [class.dark:bg-slate-600]="activeTab === tab"
                  [class.dark:text-primary-400]="activeTab === tab"
                  class="px-4 py-1.5 rounded-md text-sm font-medium text-slate-500 dark:text-slate-400 transition-all duration-200 cursor-pointer whitespace-nowrap">
            {{ tab }}
          </button>
        </div>
      </div>

      <div class="overflow-x-auto flex-1">
        <table class="w-full text-left text-sm">
          <thead class="text-slate-400 dark:text-slate-500 font-medium text-xs uppercase bg-slate-50 dark:bg-slate-800/50 border-b border-slate-100 dark:border-slate-700">
            <tr>
              <th class="px-6 py-4">ID</th>
              <th class="px-6 py-4">Subject</th>
              <th class="px-6 py-4">Status</th>
              <th class="px-6 py-4 text-right">Created</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-50 dark:divide-slate-700">
            <tr *ngFor="let t of filteredTickets" class="group hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
              <td class="px-6 py-4 font-mono text-xs text-slate-400 group-hover:text-primary-500 transition-colors">#{{ t.id }}</td>
              <td class="px-6 py-4 font-medium text-slate-700 dark:text-slate-200">{{ t.subject }}</td>
              <td class="px-6 py-4">
                <span [class]="getStatusClass(t.status)" class="px-2.5 py-1 rounded-full text-xs font-semibold border border-transparent">
                  {{ t.status }}
                </span>
              </td>
              <td class="px-6 py-4 text-right text-slate-400 text-xs">{{ t.created }}</td>
            </tr>
            
            <tr *ngIf="filteredTickets.length === 0">
                <td colspan="4" class="px-6 py-8 text-center text-slate-400 text-sm">
                    No tickets found for "{{ activeTab }}"
                </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  `
})
export class Tickets {
  tabs = ['All', 'Open', 'In Progress', 'Closed'];
  activeTab = 'All';

  tickets = [
    { id: '1234', subject: 'Login Issue on iOS', status: 'Open', created: '2m ago' },
    { id: '5678', subject: 'Payment Gateway Timeout', status: 'In Progress', created: '1h ago' },
    { id: '9101', subject: 'Dark Mode Feature Request', status: 'Closed', created: 'Yesterday' },
    { id: '1121', subject: 'Email Notifications Bouncing', status: 'Open', created: '2 days ago' },
    { id: '3321', subject: 'Account Deletion Request', status: 'In Progress', created: '3 days ago' },
    { id: '4452', subject: 'Reset Password Link Expired', status: 'Closed', created: '4 days ago' },
  ];

  get filteredTickets() {
    if (this.activeTab === 'All') {
      return this.tickets;
    }
    return this.tickets.filter(t => t.status === this.activeTab);
  }

  getStatusClass(status: string) {
    if (status === 'Open') return 'bg-emerald-50 text-emerald-600 dark:bg-emerald-500/10 dark:text-emerald-400 dark:border-emerald-500/20';
    if (status === 'In Progress') return 'bg-blue-50 text-blue-600 dark:bg-blue-500/10 dark:text-blue-400 dark:border-blue-500/20';
    return 'bg-slate-100 text-slate-500 dark:bg-slate-700 dark:text-slate-400';
  }
}