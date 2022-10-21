require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create :user }
  before(:each) { sign_in user }

  describe "GET /tasks" do
    it 'has a correct title' do
      visit '/tasks'
      expect(page).to have_content 'Lista de Tareas'
    end
  end

  describe "POST /tasks" do
    let!(:category) { create :category }
    let!(:participant) { create :user }
    it 'creates a new task', js: true do
      visit '/tasks/new'
      fill_in('task[name]', with: "Tarea")
      fill_in('task[description]', with: "Descripcion")
      fill_in('task[due_date]', with: Date.new + 5.days)
      select(category.name, from: 'task[category_id]')
      click_button('Agregar participante')
      # binding.pry
      xpath = '/html/body/div/div[2]/div/div/form/div[2]/div[1]'
      within(:xpath, xpath) do
        select(participant.email, from: 'Usuario')
        select('responsible', from: 'Rol')
      end
      click_button('Crear Task')
      expect(page).to have_content("Task was successfully created.")

    end
  end
end
